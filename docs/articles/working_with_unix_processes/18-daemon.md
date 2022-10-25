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

Eche un vistazo a la salida del siguiente fragmento.

```ruby
puts Process.getpgrp
puts Process.pid
```

[<< back](README.md)
