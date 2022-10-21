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

[<< back](README.md)
