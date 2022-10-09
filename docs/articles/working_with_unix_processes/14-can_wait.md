[<< back](README.md)

# Los procesos pueden esperar

En los ejemplos de fork(2) hasta ahora hemos dejado que el proceso padre continúe en paralelo con el proceso hijo. En algunos casos, esto conducía a resultados extraños, como cuando el proceso principal salía antes que el proceso secundario.

Ese tipo de escenario realmente solo es adecuado para un caso de uso, disparar y olvidar. Es útil cuando desea que un proceso secundario maneje algo de forma asíncrona, pero el proceso principal todavía tiene su propio trabajo que hacer.

```ruby
message = 'Good Morning'
recipient = 'tree@mybackyard.com'

fork do
  # In this contrived example the parent process forks a child to take
  # care of sending data to the stats collector. Meanwhile the parent
  # process has continued on with its work of sending the actual payload.

  # The parent process doesn't want to be slowed down with this task, and
  # it doesn't matter if this would fail for some reason.
  StatsCollector.record message, recipient
end

# send message to recipient
```

## Cuidado de niños

Para la mayoría de los otros casos de uso que involucran fork(2), querrá alguna forma de controlar los procesos de su hijo. En Ruby, `Process.wait` proporciona una técnica para esto. Reescribamos nuestro ejemplo de inducción de huérfanos del último capítulo para realizarlo con menos sorpresas.

```ruby
fork do
  5.times do
    sleep 1
    puts "I am an orphan!"
  end
end

Process.wait
abort "Parent process died..."
```

Esta vez la salida se verá así:

```
I am an orphan!
I am an orphan!
I am an orphan!
I am an orphan!
I am an orphan!
Parent process died...
```

No solo eso, sino que el control no volverá a la terminal hasta que se haya impreso toda la salida.

Entonces, ¿qué hace `Process.wait`? **`Process.wait` es una llamada de bloqueo que indica al proceso principal que espere a que finalice uno de sus procesos secundarios antes de continuar.**

## `Process.wait` y primos

Mencioné algo importante en esa última declaración, `Process.wait` bloquea hasta que cualquiera de sus procesos secundarios finalice. Si tiene un padre que está cuidando a más de un proceso secundario y está utilizando `Process.wait`, necesita saber cuál salió. Para ello, puede utilizar el valor de retorno.

`Process.wait` devuelve el pid del niño que salió. Échale un vistazo.

```ruby
# We create 3 child processes.
3.times do
  fork do
    # Each one sleeps for a random amount of number less than 5 seconds.
    sleep rand(5)
  end
end

3.times do
  # We wait for each child process to exit and print the pid that
  # gets returned.
  puts Process.wait
end  
```

## Comunicarse con `Process.wait2`

¡Pero espera! ¡`Process.wait` tiene un primo llamado `Process.wait2`!

¿Por qué la confusión de nombres? Tiene sentido una vez que sabe que `Process.wait` devuelve 1 valor (pid), pero `Process.wait2` devuelve 2 valores (pid, status).

Este estado se puede utilizar como comunicación entre procesos a través de códigos de salida. En nuestro capítulo sobre Códigos de salida, mencionamos que puede usar códigos de salida para codificar información para otros procesos. `Process.wait2` le da acceso directo a esa información.

El estado devuelto por `Process.wait2` es una instancia de `Process::Status`. Tiene mucha información útil adjunta para descubrir exactamente cómo salió un proceso.

```ruby
# We create 5 child processes.
5.times do
  fork do
    # Each generates a random number. If even they exit
    # with a 111 exit code, otherwise they use a 112 exit code.
    if rand(5).even?
      exit 111
    else
      exit 112
    end
  end
end

5.times do
  # We wait for each of the child processes to exit.
  pid, status = Process.wait2

  # If the child process exited with the 111 exit code
  # then we know they encountered an even number.
  if status.exitstatus == 111
    puts "#{pid} encountered an even number!"
  else
    puts "#{pid} encountered an odd number!"
  end
end
```

¡Comunicación entre procesos sin usar el sistema de archivos o la red!

## Esperando hijos específicos

¡Pero espera! Los primos `Process.wait` tienen dos primos más. `Process.waitpid` y `Process.waitpid2`.

Probablemente puedas adivinar lo que hacen. Funcionan igual que `Process.wait` y `Process.wait2` excepto que, en lugar de esperar a que salga un hijo, solo esperan a que salga un hijo específico, especificado por pid.

```ruby
favourite = fork do
  exit 77
end

middle_child = fork do
  abort "I want to be waited on!"
end

pid, status = Process.waitpid2 favourite
puts status.exitstatus
```

Aunque parece que `Process.wait` y `Process.waitpid` proporcionan un comportamiento diferente, ¡no se deje engañar! En realidad, tienen un alias para lo mismo. Ambos aceptarán los mismos argumentos y se comportarán igual.

Puede pasar un pid a `Process.wait` para que espere a un proceso secundario específico, y puede pasar -1 como pid a `Process.waitpid` para que espere a cualquier proceso secundario.

Lo mismo ocurre con `Process.wait2` y `Process.waitpid2`.

Al igual que con `Process.pid` frente a $$, creo que es importante que, como programadores, usemos las herramientas proporcionadas para revelar nuestra intención siempre que sea posible. Aunque estos métodos son idénticos, debe usar `Process.wait` cuando esté esperando un proceso secundario y use `Process.waitpid` cuando esté esperando un proceso específico.

## Condiciones de carrera

Mientras observa estos ejemplos de códigos simples, puede comenzar a preguntarse acerca de las condiciones de carrera.

¿Qué pasa si el código que maneja un proceso cerrado todavía se está ejecutando cuando sale otro proceso secundario? ¿Qué pasa si no he regresado a `Process.wait` y sale otro proceso? Vamos a ver:

```ruby
# We create two child processes.
2.times do
  fork do
    # Both processes exit immediately.
    abort "Finished!"
  end
end

# The parent process waits for the first process, then sleeps for 5 seconds.
# In the meantime the second child process has exited and is no
# longer running.
puts Process.wait
sleep 5

# The parent process asks to wait once again, and amazingly enough, the second
# process' exit information has been queued up and is returned here.
puts Process.wait
```

Como puede ver, esta técnica está libre de condiciones de carrera. El kernel pone en cola la información sobre los procesos finalizados para que el padre siempre reciba la información en el orden en que salieron los hijos.

Por lo tanto, incluso si el padre tarda en procesar cada hijo que sale, siempre podrá obtener la información de cada hijo cuando esté listo para ello.

Tenga en cuenta que llamar a cualquier variante de `Process.wait` cuando no hay procesos secundarios generará `Errno::ECHILD`. Siempre es una buena idea realizar un seguimiento de cuántos procesos secundarios ha creado para no encontrarse con esta excepción.

## En el mundo real

La idea de observar los procesos secundarios es el núcleo de un patrón de programación común de Unix. El patrón a veces se denomina procesos de niñera, maestro/trabajador o prebifurcación.

En el centro de este patrón está el concepto de que tiene un proceso que bifurca varios procesos secundarios, para la concurrencia, y luego pasa su tiempo cuidándolos: asegurándose de que sigan respondiendo, reaccionando si alguno de ellos sale, etc.

Por ejemplo, el servidor web Unicorn (http://unicorn.bogomips.org) emplea este patrón. Usted le dice cuántos procesos de trabajo desea que inicie por usted, 5 por ejemplo.

Luego, se iniciará un proceso de `unicorn` que hará `fork` de 5 procesos secundarios para manejar las solicitudes web. El proceso principal (o maestro) mantiene un latido con cada hijo y garantiza que todos los procesos secundarios sigan respondiendo.

Este patrón permite tanto la concurrencia como la confiabilidad. Lea más sobre Unicornio en su Apéndice al final del libro.

Para un uso alternativo de esta técnica, lea la clase Lookout en el proyecto Spyglass adjunto.

## Llamadas al sistema

Ruby's `Process.wait` y los primos se asignan a waitpid(2).

[<< back](README.md)
