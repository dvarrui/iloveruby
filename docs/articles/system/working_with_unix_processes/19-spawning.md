[<< back](README.md)

# Spawning terminal process

Una interacción común en un programa de Ruby es la de ejecutar un comando en una terminal. Esto sucede sobretodo cuando estamos escribiendo un script de Ruby para unir algunos comandos. Hay varias formas de generar procesos para ejecutar comandos de terminal en Ruby.

Antes de ver las diferentes formas de hacerlo, veamos el mecanismo que se usa en profundidad.

## fork + exec

Todos los métodos que veremos a continuación son variaciones de un tema: fork(2) + execve(2).

Ya hemos visto fork(2) en capítulos anteriores, pero este es nuestro primer vistazo a execve(2). Es bastante simple, execve(2) le permite reemplazar el proceso actual con un proceso diferente.

Dicho de otra manera: execve(2) le permite transformar el proceso actual en cualquier otro proceso. Puede tomar un proceso Ruby y convertirlo en un proceso Python, un proceso ls(1) u otro proceso Ruby.

execve(2) transforma el proceso y nunca regresa. Una vez que haya transformado su proceso de Ruby en otra cosa, nunca podrá volver.

```ruby
exec 'ls', '--help'
```

El combo fork + exec es bastante común cuando se generan nuevos procesos. execve(2) es una forma muy eficiente de transformar el proceso actual en otro; el único inconveniente es que su proceso actual se ha ido. Ahí es donde fork(2) es útil.

Puede usar fork(2) para crear un nuevo proceso, luego use execve(2) para transformar ese proceso en lo que quiera. ¡Voila! Su proceso actual sigue ejecutándose como antes y pudo generar cualquier otro proceso que desee.

Si su programa depende de la salida de la llamada execve(2), puede usar las herramientas que aprendimos en los capítulos anteriores para manejarlo. `Process.wait` se asegurará de que su programa espere a que el proceso secundario termine lo que esté haciendo para que pueda recuperar el resultado.

## Descriptores de archivos y exec

En el nivel del sistema operativo, una llamada a execve(2) no cierra ningún descriptor de archivo abierto de forma predeterminada.

Sin embargo, una llamada a `exec` de Ruby cerrará todos los descriptores de archivos abiertos de forma predeterminada (excluyendo los flujos estándar).

En otras palabras, el comportamiento predeterminado del sistema operativo al ejecutar `exec ('ls')` sería el de dar a `ls` una copia de cualquier descriptor de archivo abierto, por ejemplo. una conexión de base de datos. Esto rara vez es lo que desea, por lo que el valor predeterminado en Ruby es cerrar todos los descriptores de archivos abiertos antes de ejecutar un `exec`.

Este comportamiento predeterminado de cerrar los descriptores de archivos en `exec` evita las "fugas" de los descriptores de archivos. Puede ocurrir una fuga cuando se hace un fork + exec para generar otro proceso que no necesita los descriptores de archivo que haya abiertos actualmente (como las conexiones de su base de datos, archivos de registro, etc.) Una fuga puede desperdiciar recursos pero, lo que es peor, puede causar estragos cuando intenta cerrar la conexión de su base de datos, al descubrir que otro proceso erróneamente todavía tiene la conexión abierta.

Sin embargo, a veces es posible que quiera mantener un descriptor de archivo abierto, para pasar un archivo de registro abierto o un socket en vivo a otro programa que se está iniciando a través de `exec` (el servidor web Unicorn tiene este comportamiento para permitir reinicios sin perder ninguna conexión. Al pasar el oyente abierto socket a la nueva versión de sí mismo a través de un `exec`, asegura que el socket del oyente nunca se cierre durante un reinicio) Podemos controlar este comportamiento pasando un hash de opciones al `exec` y asignando números de descriptor de archivo a objetos IO, como se ve en el siguiente ejemplo.

```ruby
hosts = File.open('/etc/hosts')

python_code = %Q[import os; print os.fdopen(#{hosts.fileno}).read()]

# The hash as the last arguments maps any file descriptors that should
# stay open through the exec.
exec 'python', '-c', python_code, {hosts.fileno => hosts}
```

En este ejemplo, se abre el archivo `/etc/hosts` al inicio. Luego se ejecuta un proceso de `python` con el número de descriptor asociado al archivo `/etc/hosts`. `python` reconoce este descriptor de archivo (porque se compartió a través de execve(2)) y puede leerlo sin tener que abrir el archivo nuevamente.

Observe las opciones de asignación hash del número de descriptor de archivo al objeto `IO`. Si elimina ese hash, el programa Python no podrá abrir el descriptor del archivo, esa declaración lo mantiene abierto a través de execve (2).

A diferencia de fork(2), execve(2) **no** comparte memoria con el proceso recién creado. En el ejemplo anterior de python, toda la asignación de memoria para el programa Ruby se eliminó cuando se llamó a execve(2), dejando al programa python con una pizarra en blanco en términos de uso de memoria.

## Argumentos para `exec`

En los ejemplos anteriores se envían una serie de argumentos a `exec`, en lugar de pasarlos como una cadena. Hay una sutil diferencia entre las dos formas de pasar los argumentos.

Si pasamos un string a `exec`, se iniciará un proceso de shell y se pasa la cadena al shell para que la interprete. Si pasamos una lista, omitirá el shell y configurará la lista directamente como `ARGV` para el nuevo proceso.

En general, evite pasar una cadena a menos que realmente sea necesario. Pase una lista siempre que sea posible. Pasar una cadena y ejecutar código a través del shell puede generar problemas de seguridad. Si hay datos de entrada por parte del usuario, es posible que se inyecte un comando malicioso directamente en la shell, y se podría obtener acceso a cualquier privilegio que tenga el proceso actual. En el caso de que desee hacer algo como `exec('ls * | awk '{print($1)}')`, entonces tiene que pasarlo como una cadena.

## Kernel#system

```ruby
system('ls')
system('ls', '--help')
system('git log | tail -10')
```

El valor de retorno de `Kernel#system` refleja el código de salida del comando de terminal de una forma más simple. Si el código de salida del comando de terminal era 0, devuelve `true`; de lo contrario, devuelve `false`.

Los flujos estándar del comando de terminal se comparten con el proceso actual (a través de la magia de fork(2)), por lo que cualquier salida que provenga del comando de terminal debe verse de la misma manera que la salida del proceso actual.

## Kernel#\`

```ruby
`ls`
`ls --help`
%x[git log | tail -10]
```

`Kernel#`\` funciona de forma diferente. El valor devuelto es el `STDOUT` del programa de terminal recopilado en una cadena.

Como se mencionó, usa fork(2) por debajo del capó y no hace nada especial con `STDERR`, por lo que puede ver en el segundo ejemplo donde `STDERR` se muestra en pantalla al igual que con `Kernel#system`.

`Kernel#`\` y `%x[]` hacen exactamente lo mismo.

## Process.spawn

```ruby
# This call will start up the 'rails server' process with the
# RAILS_ENV environment variable set to 'test'.
Process.spawn({'RAILS_ENV' => 'test'}, 'rails server')

# This call will merge STDERR with STDOUT for the duration
# of the 'ls --help' program.
Process.spawn('ls', '--zz', STDERR => STDOUT)
```

`Process.spawn` es diferente a los demás en que no bloquea.

Si comparamos los siguientes dos ejemplos, vemos que el `Kernel#system` se bloquea hasta que finalice el comando, mientras que `Process.spawn` regresará inmediatamente.

```ruby
# Do it the blocking way
system 'sleep 5'

# Do it the non-blocking way
Process.spawn 'sleep 5'

# Do it the blocking way with Process.spawn
# Notice that it returns the pid of the child process
pid = Process.spawn 'sleep 5'
Process.waitpid(pid)
```

Este último ejemplo es un buen ejemplo de la flexibilidad de la programación de Unix. En capítulos anteriores hablamos sobre `Process.wait`, pero siempre en el contexto de bifurcar y luego ejecutar código Ruby. En este ejemplo se puede ver que al kernel no le importa lo que esté haciendo en su proceso, siempre funcionará igual.

Entonces, aunque hagamos un fork(2) y luego ejecutemos sleep(1) (un programa C), el kernel todavía sabe cómo esperar a que termine ese proceso. No solo eso, podrá devolver correctamente el código de salida tal como ocurría en nuestros programas de Ruby.

Todo el código tiene la misma apariencia para el kernel; eso lo convierte en un sistema muy flexible. Puede usar cualquier lenguaje de programación para interactuar con cualquier otro lenguaje de programación, y todos se tratarán igual.

`Process.spawn` tiene opciones que le permiten controlar el comportamiento del proceso hijo. Consulte el rdoc oficial (http://www.ruby-doc.org/core-1.9.3/Process.html#method-c-spawn) para tener más información.

## IO.popen#

[<< back](README.md)
