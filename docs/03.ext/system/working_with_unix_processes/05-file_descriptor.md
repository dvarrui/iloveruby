[<< back](README.md)

# Los procesos tienen descriptores de archivo

De la misma manera que los pid representan procesos en ejecución, los descriptores de archivos representan archivos abiertos.

## Todo es un archivo

Una parte de la filosofía Unix: en la tierra de Unix 'todo es un archivo'. Esto significa que los dispositivos se tratan como archivos, los sockets y las tuberías se tratan como archivos y los archivos se tratan como archivos.

Dado que todas estas cosas se tratan como archivos, **usaré la palabra 'recurso' cuando hable de archivos en un sentido general** (incluidos dispositivos, tuberías, enchufes, etc.) y **usaré la palabra ' archivo' cuando me refiero a la definición clásica** (un archivo en el sistema de archivos).

## Los descriptores representan recursos

Cada vez que abre un recurso en un proceso en ejecución, se le asigna un número de descriptor de archivo. Los descriptores de archivo NO se comparten entre procesos no relacionados, viven y mueren con el proceso al que están vinculados, al igual que cualquier recurso abierto para un proceso se cierra cuando sale. Hay una semántica especial para compartir descriptores de archivos cuando bifurca un proceso, Veremos más sobre esto más adelante.

> En Ruby, los recursos abiertos están representados por la clase `IO`. Cualquier objeto `IO` puede tener un número de descriptor de archivo asociado. Utilice `IO#fileno` para acceder a él.

```ruby
passwd = File.open('/etc/passwd')
puts passwd.fileno
# => 3
```

Cualquier recurso que abra su proceso obtiene un número único que lo identifica. Así es como el núcleo realiza un seguimiento de los recursos que utiliza su proceso.

¿Qué sucede cuando tenemos varios recursos abiertos?

```ruby
passwd = File.open('/etc/passwd')
puts passwd.fileno

hosts = File.open('/etc/hosts')
puts hosts.fileno

# Close the open passwd file. The frees up its file descriptor
# number to be used by the next opened resource.
passwd.close

null = File.open('/dev/null')
puts null.fileno

# outputs:
# => 3
# => 4
# => 3
```

Hay dos conclusiones clave de este ejemplo.

1. A los números de descriptor de archivo se les asigna el valor más bajo no utilizado. El primer archivo que abrimos, `passwd`, obtuvo el descriptor de archivo #3, el siguiente archivo abierto obtuvo el #4 porque el #3 ya estaba en uso.
1. Una vez que se cierra un recurso, su número de descriptor de archivo vuelve a estar disponible. Una vez que cerramos el archivo `passwd`, su número de descriptor de archivo volvió a estar disponible. Entonces, cuando abrimos el archivo en `dev/null`, se le asignó el valor más bajo sin usar, que entonces era el #3.

Es importante tener en cuenta que los descriptores de archivos solo realizan un seguimiento de los recursos abiertos. Los recursos cerrados no reciben un número de descriptor de archivo.

Volviendo al punto de vista del kernel, esto tiene mucho sentido. Una vez que se cierra un recurso, ya no necesita interactuar con la capa de hardware, por lo que el kernel puede dejar de realizar un seguimiento de él.

Según lo anterior, los descriptores de archivos a veces se denominan "descriptores de archivos abiertos". Este nombre es inapropiado ya que no existe tal cosa como un "descriptor de archivo cerrado". De hecho, intentar leer el número del descriptor de archivo de un recurso cerrado generará una excepción:

```ruby
passwd = File.open('/etc/passwd')
puts passwd.fileno
passwd.close
puts passwd.fileno

# outputs:
# => 3
# => -e:4:in `fileno': closed stream (IOError)
```

Es posible que haya notado que cuando abrimos un archivo y solicitamos su número de descriptor de archivo, el valor más bajo que obtenemos es 3. ¿Qué pasó con 0, 1 y 2?

## Flujos estándar

Cada proceso de Unix viene con tres recursos abiertos. Estos son sus recursos de entrada estándar (STDIN), salida estándar (STDOUT) y error estándar (STDERR).

Estos recursos estándar existen por una razón muy importante que hoy en día damos por sentado. STDIN proporciona una forma genérica de leer entradas desde dispositivos de teclado o tuberías (pipes), STDOUT y STDERR proporcionan formas genéricas de escribir salidas en monitores, archivos, impresoras, etc. Esta fue una de las innovaciones de Unix.

¡Antes de que existiera STDIN, su programa tenía que incluir un controlador de teclado para todos los teclados que quería admitir! Y si quería imprimir algo en la pantalla, tenía que saber cómo manipular los píxeles necesarios para hacerlo. Así que estemos todos agradecidos por los flujos estándar.

```ruby
puts STDIN.fileno
puts STDOUT.fileno
puts STDERR.fileno

# outputs:
# => 0
# => 1
# => 2
```

Ahí es donde tenemos los primeros 3 números descriptores de archivo.

## En el mundo real

Los descriptores de archivos están en el centro de la programación de red usando sockets, pipes, etc. y también están en el centro de cualquier operación del sistema de archivos.

Por lo tanto, se usan por todos los procesos en ejecución y son el núcleo de la mayoría de las cosas interesantes que puede hacer con una computadora. Verá muchos más ejemplos de cómo usarlos en los siguientes capítulos o en el proyecto Spyglass adjunto.

## Llamadas al sistema

Muchos métodos en la clase `IO` de Ruby se asignan a llamadas al sistema del mismo nombre. Estos incluyen open(2), close(2), read(2), write(2), pipe(2), fsync(2), stat(2), entre otros.

[<< back](README.md)
