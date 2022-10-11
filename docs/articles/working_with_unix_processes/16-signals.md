[<< back](README.md)

# Los procesos pueden capturar señales

En el último capítulo vimos `Process.wait`. Es un buen modo de que un proceso principal controle sus procesos secundarios. Sin embargo, es una llamada de bloqueo: no volverá hasta que muera un proceso secundario.

¿Qué debe hacer un padre ocupado? No todos los padres pueden darse el lujo de esperar a sus hijos todo el día. ¡Hay una solución para los padres ocupados! Y es nuestra introducción a las señales de Unix.

## Capturando SIGCHLD

Tomemos un ejemplo simple del último capítulo y reescribámoslo para un proceso principal ocupado.

```ruby
child_processes = 3
dead_processes = 0
# We fork 3 child processes.
child_processes.times do
  fork do
    # They sleep for 3 seconds.
    sleep 3
  end
end

# Our parent process will be busy doing some intense mathematics.
# But still wants to know when one of its children exits.

# By trapping the :CHLD signal our process will be notified by the kernel
# when one of its children exits.
trap(:CHLD) do
  # Since Process.wait queues up any data that it has for us we can ask for it
  # here, since we know that one of our child processes has exited.

  puts Process.wait
  dead_processes += 1
  # We exit explicitly once all the child processes are accounted for.
  exit if dead_processes == child_processes
end

# Work it.
loop do
  (Math.sqrt(rand(44)) ** 8).floor
  sleep 1
end
```

## SIGCHLD y Concurrencia

Antes de continuar, debo mencionar una advertencia. **La entrega de la señal no es confiable**. Con esto quiero decir que si su código está manejando una señal CHLD mientras otro proceso secundario muere, _puede recibir o no una segunda señal CHLD_.

Esto puede conducir a resultados inconsistentes según el fragmento de código anterior. A veces, el momento será tal que las cosas funcionarán perfectamente y, a veces, realmente "perderá" una instancia de muerte del proceso hijo.

Este comportamiento solo ocurre cuando se recibe la misma señal varias veces sucesivas; siempre puede contar con al menos una instancia de la señal que llega. Esta misma advertencia es válida para otras señales que maneja en Ruby; siga leyendo para saber más sobre ellos.

Para manejar correctamente CHLD, debe llamar a `Process.wait` en un bucle y buscar tantos procesos secundarios inactivos como estén disponibles, ya que es posible que haya recibido varias señales CHLD desde que ingresó al controlador de señales. Pero... ¿`Process.wait` no es una llamada de bloqueo? Si solo hay un proceso secundario muerto y vuelvo a llamar a `Process.wait`, ¿cómo evitaré bloquear todo el proceso?

Ahora llegamos al segundo argumento de `Process.wait`. En el último capítulo vimos pasar un pid a `Process.wait` como primer argumento, pero también toma un segundo argumento, flags. Una de esos flags le indica al kernel que no bloquee si no ha salido ningún hijo. ¡Justo lo que necesitamos!

Hay una constante que representa el valor de este flag, `Process::WNOHANG`, y se puede usar así:

```ruby
Process.wait(-1, Process::WNOHANG)
```

Muy fácil.

Aquí hay una reescritura del fragmento de código del comienzo de este capítulo de modo no se "perderá" ninguna muerte de los procesos hijos:

```ruby
child_processes = 3
dead_processes = 0
# We fork 3 child processes.
child_processes.times do
  fork do
    # They sleep for 3 seconds.
    sleep 3
  end
end

# Sync $stdout so the call to #puts in the CHLD handler isn't
# buffered. Can cause a ThreadError if a signal handler is
# interrupted after calling #puts. Always a good idea to do
# this if your handlers will be doing IO.
$stdout.sync = true

# Our parent process will be busy doing some intense mathematics.
# But still wants to know when one of its children exits.

# By trapping the :CHLD signal our process will be notified by the kernel
# when one of its children exits.
trap(:CHLD) do
  # Since Process.wait queues up any data that it has for us we can ask for it
  # here, since we know that one of our child processes has exited.

  # We loop over a non-blocking Process.wait to ensure that any dead child
  # processes are accounted for.
  begin
    while pid = Process.wait(-1, Process::WNOHANG)
      puts pid
      dead_processes += 1      
    end
  rescue Errno::ECHILD
  end
end

loop do
  # We exit ourself once all the child processes are accounted for.
  exit if dead_processes == child_processes

  sleep 1
end
```

Recordar que incluso esta variante de `Process.wait`, generará `Errno::ECHILD` si no existen procesos secundarios. Dado que las señales pueden llegar en cualquier momento, es posible que llegue la última señal CHLD después de que el controlador CHLD anterior haya llamado a `Process.wait` dos veces y haya obtenido el último estado disponible. Este material asíncrono puede ser alucinante. Cualquier línea de código se puede interrumpir con una señal. ¡Quedas advertido!

Por lo tanto, debe manejar la excepción `Errno::ECHILD` en su controlador de señales CHLD. Además, si no sabe cuántos procesos secundarios está esperando, debe rescatar esa excepción y manejarla correctamente.

# Cebador de señales

Esta fue nuestra primera incursión en el tema de las señales de Unix. Las señales son comunicaciones asíncronas. Cuando un proceso recibe una señal del kernel, puede hacer una de las siguientes cosas:

1. Ignorar la señal
2. Realizar una acción específica
3. Realizar la acción predeterminada

## ¿De dónde vienen las señales?

Técnicamente, las señales son enviadas por el kernel, al igual que los mensajes de texto son enviados por un operador de telefonía celular. Pero los mensajes de texto tienen un remitente original, al igual que las señales. Las señales se envían de un proceso a otro utilizando el kernel como intermediario.

El propósito original de las señales era especificar diferentes formas en que un proceso debería ser eliminado. Comencemos por ahí.

Iniciemos dos programas Ruby y usaremos uno para matar al otro.

> Para estos ejemplos no usaremos `irb`, porque `irb` define sus propios controladores de señales que interfieren en nuestras demostraciones. En su lugar, solo usaremos el propio programa Ruby.
>
> Pruebe lo siguiente: inicie el programa Ruby sin argumentos. Introduce algún código. Presiona Ctrl-D.
>
> Esto ejecuta el código que ingresó y luego sale.

Inicie dos procesos Ruby usando la técnica mencionada anteriormente y mataremos a uno de ellos usando una señal.

1. En la primera sesión de Ruby, ejecute el siguiente código:
```ruby
puts Process.pid
sleep # so that we have time to send it a signal
# Ctrl-D
```
2. En la segunda sesión de Ruby, escriba el siguiente comando para eliminar la primera sesión con una señal:
```ruby
Process.kill(:INT, <pid of first session>)
# Ctrl-D
```

De esta forma, el segundo proceso envia una señal "INT" al primer proceso, lo que provoca su salida. "INT" es la abreviatura de "INTERRUPCIÓN".

De forma predeterminada cuando un proceso recibe esta señal es que debe interrumpir lo que esté haciendo y salir de inmediato.

## Panorámica

A continuación se muestra una tabla que muestra las señales comúnmente compatibles con los sistemas Unix. Cada proceso de Unix podrá responder a estas señales y cualquier señal puede enviarse a cualquier proceso.

Cuando se nombran señales, la porción SIG del nombre es opcional. La columna Acción de la tabla describe la acción predeterminada para cada señal:

**Term**: significa que el proceso terminará inmediatamente.

**Core**: significa que el proceso terminará inmediatamente y volcará el core (seguimiento de pila).

**Ign**: significa que el proceso ignorará la señal

**Stop**: significa que el proceso se detendrá (es decir, pausa)

**Cont**: significa que el proceso se reanudará (es decir, unpause)

```
Signal	  Value	    Action   Comment
-------------------------------------------------------------------------
SIGHUP	     1	     Term    Hangup detected on controlling terminal
                             or death of controlling process
SIGINT	     2	     Term    Interrupt from keyboard
SIGQUIT      3	     Core    Quit from keyboard
SIGILL       4	     Core    Illegal Instruction
SIGABRT	     6	     Core    Abort signal from abort(3)
SIGFPE       8	     Core    Floating point exception
SIGKILL	     9	     Term    Kill signal
SIGSEGV	    11	     Core    Invalid memory reference
SIGPIPE	    13	     Term    Broken pipe: write to pipe with no readers
SIGALRM	    14	     Term    Timer signal from alarm(2)
SIGTERM	    15	     Term    Termination signal
SIGUSR1	 30,10,16    Term    User-defined signal 1
SIGUSR2	 31,12,17    Term    User-defined signal 2
SIGCHLD	 20,17,18    Ign     Child stopped or terminated
SIGCONT	 19,18,25    Cont    Continue if stopped
SIGSTOP	 17,19,23    Stop    Stop process
SIGTSTP	 18,20,24    Stop    Stop typed at tty
SIGTTIN	 21,21,26    Stop    tty input for background process
SIGTTOU	 22,22,27    Stop    tty output for background process

The signals SIGKILL and SIGSTOP cannot be trapped, blocked, or ignored.
```

Esta tabla da una idea aproximada de qué debemos esperar cuando se envía una determinada señal a un proceso. Podemos ver que, por defecto, la mayoría de las señales terminan un proceso.

Es interesante observar las señales SIGUSR1 y SIGUSR2. La acción de estas señales será definida por su proceso. Veremos en breve que somos libres de redefinir cualquiera de las acciones de señal que nos plazca, pero esas dos señales están destinadas a ese uso.

## Redefinición de señales

Volvamos a nuestras dos sesiones de `ruby` y divirtámonos.

1. En la primera sesión de `ruby` utilice el siguiente código para redefinir el comportamiento de la señal INT:
```ruby
puts Process.pid
trap(:INT) { print "Na na na, you can't get me" }
sleep # so that we have time to send it a signal
```
Ahora nuestro proceso no saldrá cuando reciba la señal INT.

2. ¡En la segunda sesión de `ruby` emita el siguiente comando y note que el primer proceso se está burlando de nosotros!
```ruby
Process.kill(:INT, <pid of first session>)
```
3. Puedes intentar usar Ctrl-C para matar esa primera sesión, ¡y notar que responde igual!
4. Pero como decía la tabla hay algunas señales que no se pueden redefinir. SIGKILL le mostrará a ese tipo quién es el jefe.
```ruby
Process.kill(:KILL, <pid of first session>)
```

## Ignorar señales

1. En la primera sesión de `ruby` utilice el siguiente código:
```ruby
puts Process.pid
trap(:INT, "IGNORE")
sleep # so that we have time to send it a signal
```
2. En la segunda sesión de `ruby`, ponga el siguiente comando y observe que el primer proceso no se ve afectado.
```ruby
```

La primera sesión de `ruby` no se ve afectada.

## Los gestores de señales son globales

Las señales son una gran herramienta y son perfectas para ciertas situaciones. Pero es bueno tener en cuenta que **atrapar una señal es un poco como usar una variable global**, es posible que esté sobrescribiendo algo de lo que depende algún otro código. Y a diferencia de las variables globales, los gestores de señales no se pueden crear espacios de nombres.

Así que asegúrese de leer la siguiente sección antes de incluir gestores de señales en todas sus bibliotecas de código abierto :)

## Ser amable con la redefinición de señales

Hay una manera de preservar los controladores definidos por otro código de Ruby, de modo que su controlador de señales no pisotee a otros que ya estén definidos.

Es algo como esto:

```ruby
trap(:INT) { puts 'This is the first signal handler' }

old_handler = trap(:INT) {
  old_handler.call
  puts 'This is the second handler'
  exit
}
sleep 5 # so that we have time to send it a signal
```

Solo envíe un Ctrl-C para ver el efecto. Ambos manejadores de señales serán invocados.

Ahora veamos si podemos preservar el comportamiento predeterminado del sistema. Presiona el siguiente código con Ctrl-C.

```ruby
system_handler = trap(:INT) {
  puts 'about to exit!'
  system_handler.call
}
sleep 5 # so that we have time to send it a signal
```

:/ Explotó esta vez. Por lo tanto, no podemos conservar el comportamiento predeterminado del sistema con esta técnica, pero podemos conservar otros controladores de código de Ruby que se hayan definido.

Según las buenas prácticas, su código no debería definir ningún controlador de señal, a menos que sea un servidor. Como en un proceso de ejecución prolongada que se inicia desde la línea de comandos. Es muy raro que el código de biblioteca atrape una señal.

```ruby
# The 'friendly' method of trapping a signal.

old_handler = trap(:QUIT) {
  # do some cleanup
  puts 'All done!'

  old_handler.call if old_handler.respond_to?(:call)
}
```

[<< back](README.md)
