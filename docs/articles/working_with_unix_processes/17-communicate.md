[<< back](README.md)

# Los procesos pueden comunicarse

Hasta ahora, hemos visto procesos relacionados que comparten memoria y comparten recursos abiertos. Pero, ¿qué pasa con la comunicación de información entre múltiples procesos?

Esto es parte de todo un campo de estudio llamado comunicación entre procesos (IPC, por sus siglas en inglés). Hay muchas formas diferentes de hacer IPC, pero voy a cubrir dos métodos comúnmente útiles: pipes(tuberías) y pares de sockets(enchufes).

## Nuestra primer pipe

Una tubería es un flujo de datos unidireccional. En otras palabras, puede abrir una tubería, un proceso puede "reclamar" un extremo y otro proceso puede "reclamar" el otro extremo. Luego, los datos pueden pasar a lo largo de la tubería, pero solo en una dirección. Entonces, si un proceso 'reclama' la posición de lector, en lugar de escritor, no podrá escribir en la tubería. Y viceversa.

Antes de involucrar múltiples procesos, veamos cómo crear una tubería y qué se obtiene:

```ruby
reader, writer = IO.pipe #=> [#<IO:fd 5>, #<IO:fd 6>]
```

`IO.pipe` devuelve una matriz de dos elementos, ambos objetos `IO`. La increíble clase IO de Ruby es la superclase de `File`, `TCPSocket`, `UDPSocket` y otras. Como tal, todos estos recursos tienen una interfaz común.

Los objetos `IO` devueltos por `IO.pipe` pueden considerarse archivos anónimos. Básicamente, se pueden tratar de la misma manera que lo haría con un archivo. Puede llamar a `#read`, `#write`, `#close`, etc. Pero no responderá a `#path` y no tendrá una ubicación en el sistema de archivos.

Todavía reteniéndose de traer múltiples procesos, demostremos la comunicación con una tubería:

```ruby
reader, writer = IO.pipe
writer.write("Into the pipe I go...")
writer.close
puts reader.read

# outputs
# => Into the pipe I go...
```

Bastante simple, ¿verdad? ¿Se dio cuenta de que tuve que cerrar el escritor después de escribir en la canalización? Esto se debe a que cuando el lector llama a `IO#read`, seguirá intentando leer datos hasta que vea un EOF (también conocido como marcador de fin de archivo (http://en.wikipedia.org/wiki/End-of-file). Esto le dice al lector que no habrá más datos disponibles para leer.

Mientras el escritor aún esté abierto, el lector puede ver más datos, por lo que espera. Al cerrar el escritor antes de leer, coloca un EOF en la tubería para que el lector deje de leer después de obtener los datos iniciales. Si omite cerrar el escritor, el lector se bloqueará y continuará intentando leer indefinidamente.

## Las tuberías son unidireccionales

```ruby
reader, writer = IO.pipe
reader.write("Trying to get the reader to write something")
```

Salida:
```
>> reader.write("Trying to get the reader to write something")
IOError: not opened for writing
       from (irb):2:in `write'
       from (irb):2
```

Los objetos `IO` devueltos por `IO.pipe` solo se pueden usar para la comunicación unidireccional. Entonces, el lector solo puede leer y el escritor solo puede escribir.

Ahora introduzcamos procesos en la mezcla.

## Compartiendo tuberías

En el capítulo sobre bifurcación, describimos cómo se comparten o copian los recursos abiertos cuando un proceso bifurca a un hijo. Las tuberías se consideran un recurso, obtienen sus propios descriptores de archivo y todo, por lo que se comparten con los procesos secundarios.

Aquí hay un ejemplo simple del uso de una tubería para comunicarse entre un proceso principal y secundario. El hijo le indica al padre que ha terminado una iteración de trabajo escribiendo en la tubería:

```ruby
reader, writer = IO.pipe

fork do
  reader.close

  10.times do
    # heavy lifting
    writer.puts "Another one bites the dust"
  end
end

writer.close
while message = reader.gets
  $stdout.puts message
end
```

La salida del ejemplo es el texto "Another one bites the dust" diez veces.

Tener en cuenta que, como arriba, los extremos no utilizados de la tubería se cierran para no interferir con el envío de EOF. En realidad, hay una capa más al considerar EOF ahora que hay dos procesos involucrados. Desde que se copiaron los descriptores de archivo, ahora hay 4 instancias flotando. Dado que solo dos de ellos se utilizarán para comunicar, las otras 2 instancias deben cerrarse. De ahí las instancias adicionales de cierre.

Dado que los extremos de la tubería son objetos `IO`, podemos llamar a cualquier método `IO` en ellos, no solo `#read` y `#write`. En este ejemplo, uso `#puts` y `#gets` para leer y escribir una cadena delimitada con una nueva línea. De hecho, se usaron aquí para simplificar un aspecto de las tuberías: las tuberías contienen un flujo de datos.

## Streams vs mensajes

Cuando decimos flujo nos referimos a que al escribir y leer datos en una tubería no existe el concepto de principio y fin. Cuando trabaja con un flujo de IO, como tuberías o conectores TCP, escribe los datos en el flujo seguido de algún delimitador específico del protocolo. Por ejemplo, HTTP utiliza una serie de saltos de línea para delimitar los encabezados del cuerpo.

Luego, al leer datos de ese flujo de IO, los lee de una vez, deteniéndose cuando se encuentra con el delimitador. Es por ese motivo se usaron `#puts` y `#gets` en el último ejemplo: se usó una nueva línea como delimitador.

Como habrá adivinado, es posible comunicarse a través de mensajes en lugar de transmisiones. No podemos hacerlo con pipe, pero podemos hacerlo con sockets Unix. Sin entrar en demasiados detalles, los sockets de Unix son un tipo de socket que solo puede comunicarse en la misma máquina física. Como tal, es mucho más rápido que los sockets TCP y se adapta perfectamente al protocolo IPC.

Aquí hay un ejemplo donde de un par de sockets Unix que pueden comunicarse a través de mensajes:

```ruby
require 'socket'
Socket.pair(:UNIX, :DGRAM, 0) #=> [#<Socket:fd 15>, #<Socket:fd 16>]
```

De esta forma se crean un par de sockets UNIX que ya conectados entre sí. Estos sockets se comunican mediante datagramas, en lugar de un flujo. De esta manera, si se escribe un mensaje _completo_ en uno de los sockets, se lee un mensaje _completo_ desde el otro socket. Sin requierir delimitadores.

A continuación una versión un poco más compleja del ejemplo de tubería donde el proceso hijo en realidad espera a que el padre le diga en qué trabajar, luego informa al padre una vez que ha terminado el trabajo:

```ruby
require 'socket'

child_socket, parent_socket = Socket.pair(:UNIX, :DGRAM, 0)
maxlen = 1000

fork do
  parent_socket.close

  4.times do
    instruction = child_socket.recv(maxlen)
    child_socket.send("#{instruction} accomplished!", 0)
  end
end
child_socket.close

2.times do
  parent_socket.send("Heavy lifting", 0)
end
2.times do
  parent_socket.send("Feather lifting", 0)
end

4.times do
  $stdout.puts parent_socket.recv(maxlen)
end
```

Salida:
```outputs:

Heavy lifting accomplished!
Heavy lifting accomplished!
Feather lifting accomplished!
Feather lifting accomplished!
```

Mientras que las tuberías nos ofrecen comunicación unidireccional, un par de sockets (enchufes) ofrecen comunicación bidireccional. El socket principal puede leer y escribir en el socket secundario y viceversa.

## ¿IPC remoto?

IPC implica comunicación entre procesos que se ejecutan en la misma máquina. Si está interesado en escalar de una máquina a muchas máquinas mientras sigue haciendo algo parecido a IPC, hay algunas cosas que debe tener en cuenta. Lo primero sería simplemente comunicarse a través de sockets TCP. Esta opción requiere más código repetitivo que las otras para un sistema no trivial. Otras soluciones posibles serían `RPC` (llamada a procedimiento remoto), un sistema de mensajería como `ZeroMQ` o el `conjunto general de sistemas distribuidos`.

## En el mundo real

Tanto las tuberías como los pares de sockets (enchufes) son abstracciones útiles para la comunicación entre procesos. Son rápidos y fáciles. A menudo se utilizan como un canal de comunicación en lugar de usar un enfoque de fuerza bruta, como una base de datos compartida o un archivo de registro.

En cuanto a qué método usar: depende de sus necesidades. Al sopesar su decisión, tenga en cuenta que las tuberías son unidireccionales y los pares de enchufes son bidireccionales.

Para ver un ejemplo más detallado, eche un vistazo a la clase maestra Spyglass en el proyecto Spyglass incluido. Utiliza un ejemplo más complicado del código que vio arriba, donde muchos procesos secundarios se comunican a través de una sola tubería con su proceso principal.

## Llamadas al sistema

`IO.pipe` de Ruby se asigna a pipe(2), `Socket.pair` se asigna a socketpair(2). `Socket.recv` se asigna a recv(2) y `Socket.send` se asigna a send(2).

[<< back](README.md)
