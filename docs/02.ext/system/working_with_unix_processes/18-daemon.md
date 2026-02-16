[<< back](README.md)

# Procesos demonio

Los procesos daemon son procesos que se ejecutan en segundo plano, en lugar de estar bajo el control de un usuario en un terminal. Ejemplos comunes de procesos daemon son servidores web o servidores de bases de datos que siempre se ejecutarán en segundo plano para atender las solicitudes.

Los procesos Daemon también son el núcleo de su sistema operativo. Hay muchos procesos que se ejecutan constantemente en segundo plano que mantienen su sistema funcionando normalmente. Estas son cosas como el servidor de ventanas en un sistema GUI, servidor de impresión o el servidor de audio para que sus altavoces estén siempre listos para reproducir esa molesta notificación de "ding".

## El primer proceso

Hay un proceso daemon en particular que tiene un significado especial para el sistema operativo. Hablamos en un capítulo anterior sobre cada proceso que tiene un proceso padre. ¿Puede eso ser cierto para todos los procesos? ¿Qué pasa con el primer proceso del sistema?

Este es un tipo de problema clásico de quién creó al creador, y tiene una respuesta simple. Cuando se arranca el núcleo, genera un proceso llamado proceso `init`. Este proceso tiene un ppid de `0` y es el "abuelo de todos los procesos". Es el primero y no tiene antepasado. Su pid es `1`.

## Creando nuestro primer proceso Daemon

¿Qué necesitamos para empezar? Poco. Cualquier proceso puede convertirse en un proceso daemon.

Veamos `rack project` para ver un ejemplo aquí. Rack se envía con un comando `rackup` para atender aplicaciones que utilizan diferentes servidores web compatibles con rack. Los servidores web son un gran ejemplo de un proceso que nunca terminará; siempre que su aplicación esté activa, necesitará un servidor que escuche las conexiones.

El comando `rackup` incluye una opción para demonizar el servidor y ejecutarlo en segundo plano. Echemos un vistazo a lo que hace.

## Buceando en Rack

```ruby
def daemonize_app
  if RUBY_VERSION < "1.9"
    exit if fork
    Process.setsid
    exit if fork
    Dir.chdir "/"
    STDIN.reopen "/dev/null"
    STDOUT.reopen "/dev/null", "a"
    STDERR.reopen "/dev/null", "a"
  else
    Process.daemon
  end
end
```

Están pasando muchas cosas. Primero saltemos al bloque else. ¡Ruby 1.9.x viene con un método llamado `Process.daemon` que demonizará el proceso actual! ¡Que conveniente!

¿Pero no quieres saber cómo funciona debajo del capó? ¡Sabía que lo habías hecho! La verdad es que si observa la fuente de MRI para `Process.daemon` y tropieza con el código C, termina haciendo exactamente lo mismo que hace Rack en el bloque if anterior.

Así que sigamos usando eso como ejemplo. Desglosaremos el código línea por línea.

## Demonizar un proceso, paso a paso

```ruby
exit if fork
```

Esta línea de código hace un uso inteligente del valor de retorno del método `fork`. Recuerde del capítulo anterior que `fork` regresa dos veces, una en el proceso padre y otra en el proceso hijo. En el proceso padre devuelve el pid del hijo y en el proceso hijo devuelve nil.

Como siempre, el valor de retorno será verdadero para el padre y falso para el hijo. Esto significa que el proceso principal saldrá y, como sabemos, los procesos secundarios huérfanos continuará con normalidad.

> Si un proceso queda huérfano, ¿qué sucede cuando solicita `Process.ppid`?
>
> Aquí es donde lo que conocemos del proceso `init` se vuelve relevante. El ppid de los procesos huérfanos siempre es 1. Este es el único proceso del cual el kernel puede estar seguro de que está activo en todo momento.

Este primer paso es imperativo al crear un daemon porque hace que la terminal que invocó este script piense que el comando está listo, devolviendo el control a la terminal y sacándolo de la ecuación.

La llamada a `Process.setsid` hace tres cosas:
1. El proceso se convierte en líder de sesión de una nueva sesión.
2. El proceso se convierte en el líder del grupo de procesos de un nuevo grupo de procesos.
3. El proceso no tiene terminal de control.

Para comprender exactamente el efecto tienen estas tres cosas, debemos salir del contexto de nuestro ejemplo de Rack por un momento y mirar un poco más profundo.

## Grupos de procesos y grupos de sesiones

Los grupos de proceso y los grupos de sesión tienen que ver con el control del trabajo. Por 'control de trabajo' me refiero a la forma en que la terminal maneja los procesos.

Comenzamos con los grupos de procesos.

Todos y cada uno de los procesos pertenecen a un grupo, y cada grupo tiene una identificación entera única. Un grupo de procesos es solo una colección de procesos relacionados, normalmente un proceso padre y sus hijos. Sin embargo, también puede agrupar sus procesos arbitrariamente configurando su ID de grupo usando `Process.setpgrp(new_group_id)`.

Echemos un vistazo a la salida del siguiente fragmento.

```ruby
puts Process.getpgrp
puts Process.pid
```

Si ejecutamos este código en una sesión `irb`, los dos valores serán iguales. Por lo general, la identificación del grupo de procesos será la misma que la identificación del líder del grupo de procesos. El líder del grupo de procesos es el proceso "de origen" de un comando de terminal. es decir. Si inicia un proceso `irb` en la terminal, se convertirá en el líder de grupo de un nuevo grupo de procesos. Cualquier proceso secundario que cree formará parte del mismo grupo de procesos.

Pruebe el siguiente ejemplo para ver que los grupos de procesos se heredan.

```ruby
puts Process.pid
puts Process.getpgrp

fork {
  puts Process.pid
  puts Process.getpgrp
}
```

Se puede ver que aunque el proceso secundario obtiene un pid único, hereda el id de grupo de su padre. Entonces estos dos procesos son parte del mismo grupo.

Anteriormente ya habíamos analizado los procesos huérfanos. En esa sección hemos dicho que los procesos secundarios no reciben un tratamiento especial por parte del núcleo. Salga de un proceso padre y el hijo continuará. Este es el comportamiento cuando un proceso padre sale, pero el comportamiento es un poco diferente cuando el proceso padre está siendo controlado por una terminal y es eliminado por una señal.

Considere por un momento: una secuencia de comandos de Ruby que se convierte en un comando de shell de ejecución prolongada, por ejemplo. una larga secuencia de comandos de copia de seguridad. ¿Qué sucede si elimina el script de Ruby con Ctrl-C?

Si hace la prueba, notará que la secuencia de comandos de copia de seguridad de ejecución prolongada no queda huérfana. No continúa cuando se elimina a su padre. No hemos configurado ningún código para reenviar la señal del padre al hijo, entonces, ¿cómo ocurre esto?

El terminal recibe la señal y la reenvía a cualquier proceso en el grupo de procesos de primer plano. En este caso, tanto el script de Ruby como el comando de shell de ejecución prolongada formarían parte del mismo grupo de procesos, por lo que ambos serían eliminados por la misma señal.

Y luego los grupos de sesión...

Un grupo de sesión es un nivel de abstracción superior, una colección de grupos de procesos. Considere el siguiente comando de shell:

```bash
git log | grep shipped | less
```

En este caso, cada comando tiene su propio grupo de procesos, ya que cada uno podría crear procesos secundarios, pero ninguno es un proceso secundario de otro. Aunque estos comandos no son parte del mismo grupo de procesos, un Ctrl-C los matará a todos.

Estos comandos son parte del mismo grupo de sesión. Cada invocación del shell obtiene su propio grupo de sesión. Una invocación puede ser un solo comando o una cadena de comandos unidos por tuberías.

Como en el ejemplo anterior, un grupo de sesión se puede adjuntar a una terminal. También podría no estar conectado a ningún terminal, como en el caso de un daemon.

e nuevo, su terminal maneja los grupos de sesiones de una manera especial: enviar una señal al líder de la sesión reenviará esa señal a todos los grupos de procesos en esa sesión, que la reenviará a todos los procesos en esos grupos de procesos. Tortugas hasta el fondo ;)

Hay una llamada al sistema para recuperar la identificación del grupo de sesión actual, getsid(2), pero la biblioteca principal de Ruby no tiene una interfaz. El uso de `Process.setsid` devolverá la identificación del nuevo grupo de sesión que crea, puede almacenarlo si lo necesita.

Entonces, volviendo a nuestro ejemplo de Rack, en la primera línea se bifurcó un proceso secundario y el padre salió. El terminal de origen reconoció la salida y le devolvió el control al usuario, pero el proceso bifurcado aún tiene la identificación de grupo y la identificación de sesión heredadas de su padre. Por el momento, este proceso bifurcado no es ni un líder de sesión ni un líder de grupo.

Entonces, la terminal todavía tiene un enlace a nuestro proceso bifurcado, si enviara una señal a su grupo de sesión, el proceso bifurcado la recibiría, pero queremos estar completamente separados de una terminal.

`Process.setsid` hará que este proceso bifurcado sea el líder de un nuevo grupo de procesos y un nuevo grupo de sesión. Tenga en cuenta que `Process.setsid` fallará en un proceso que ya es un líder de grupo de procesos, solo se puede ejecutar desde procesos secundarios.

Este nuevo grupo de sesión no tiene una terminal de control, pero técnicamente se podría asignar una.

```ruby
exit if fork
```

El proceso bifurcado que acababa de convertirse en un grupo de proceso y líder de grupo de sesión se bifurca nuevamente y luego sale.

Este proceso recién bifurcado ya no es un líder de grupo de procesos ni un líder de sesión. Dado que el líder de sesión anterior no tenía una terminal de control y este proceso no es un líder de sesión, se garantiza que este proceso nunca podrá tener una terminal de control. Los terminales solo se pueden asignar a líderes de sesión.

Este baile asegura que nuestro proceso ahora esté completamente separado de una terminal de control y se ejecutará hasta su finalización.

```ruby
Dir.chdir "/"
```

Se cambia el directorio de trabajo actual al directorio raíz del sistema. No es estrictamente necesario, pero es un paso adicional para garantizar que el directorio de trabajo actual del demonio no desaparezca durante su ejecución.

De este modo se evitan problemas en los que el directorio desde el que se inició el daemon se elimine o se desmonte por cualquier motivo.

```ruby
STDIN.reopen "/dev/null"
STDOUT.reopen "/dev/null", "a"
STDERR.reopen "/dev/null", "a"
```

Ahora se establece que todos los flujos estándar vayan a `/dev/null`, es decir, que se ignoren. Dado que el daemon ya no está conectado a una sesión de terminal, no sirven de nada. No se pueden cerrar simplemente porque algunos programas esperan que estén siempre disponibles. Redireccionarlos a `/dev/null` asegura que todavía estén disponibles pero que no tengan ningún efecto.

## En el mundo real

Como se mencionó, el comando `rackup` viene con una opción de línea de comando para demonizar el proceso. Lo mismo ocurre con cualquiera de los populares servidores web de Ruby.

Si desea profundizar en más aspectos internos de los procesos de daemon, debe consultar los [`daemons` rubygem](http://rubygems.org/gems/daemons).

Cuando quiera crear un proceso daemon, debe hacerse una pregunta básica: ¿Este proceso debe permanecer receptivo para siempre?

Si la respuesta es no, entonces probablemente será mejor un trabajo cron o un sistema de trabajo en segundo plano. Si la respuesta es afirmativa, probablemente tenga un buen candidato para un proceso daemon.

## Llamadas al sistema

`Process.setsid` de Ruby se asigna a setsid(2), `Process.getpgrp` se asigna a getpgrp(2). Las otras llamadas al sistema mencionadas en este capítulo ya se cubrieron en detalle en capítulos anteriores.

[<< back](README.md)
