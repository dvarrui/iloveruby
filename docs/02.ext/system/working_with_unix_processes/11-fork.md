[<< back](README.md)

# Los procesos pueden bifurcarse

Forking es uno de los conceptos más poderosos en la programación de Unix. La llamada al sistema fork(2) permite que un proceso en ejecución cree un nuevo proceso mediante programación. Este nuevo proceso es una copia exacta del proceso original.

Hasta ahora hemos hablado de crear procesos lanzándolos desde la terminal. También hemos mencionado procesos del sistema operativo de bajo nivel que crean otros procesos: fork(2) es lo que se utiliza para ello.

Cuando se bifurca, el proceso que inicia fork(2) se llama "padre", y el proceso recién creado se llama "hijo".

**El proceso hijo hereda una copia de toda la memoria en uso por el proceso padre, así como cualquier descriptor de archivo abierto que pertenezca al proceso padre**. Paremos un momento para revisar los procesos secundarios desde el punto de vista de los primeros tres capítulos.

Dado que el proceso hijo es un proceso completamente nuevo, obtiene su propio pid único.

El padre del proceso hijo es, obviamente, su proceso padre. Entonces, su ppid se establece en el pid del proceso que inició fork(2).

El proceso hijo hereda cualquier descriptor de archivo abierto del padre en el momento del fork(2). Tendrá el mismo mapa de números de descriptores de archivo que tiene el proceso principal. De esta forma los dos procesos pueden compartir archivos abiertos, sockets, etc.

El proceso hijo hereda una copia de todo lo que el proceso padre tiene en la memoria principal. De esta forma, un proceso podría cargar una gran base de código, digamos una aplicación de Rails, que ocupa 500 MB de memoria principal. Entonces este proceso puede bifurcar 2 nuevos procesos secundarios. Cada uno de estos procesos secundarios tendría efectivamente su propia copia de esa base de código cargada en la memoria.

La llamada a la bifurcación regresa casi al instante, por lo que ahora tenemos 3 procesos y cada uno usa 500 MB de memoria. Perfecto para cuando desea tener varias instancias de su aplicación cargadas en la memoria al mismo tiempo. Debido a que solo un proceso necesita cargar la aplicación y la bifurcación es rápida, este método es más rápido que cargar la aplicación 3 veces en instancias separadas.

Los procesos secundarios son libres para modificar su copia de la memoria sin afectar lo que el proceso principal tiene en la memoria. Consulte el próximo capítulo para una discusión sobre la copia en escritura y cómo afecta la memoria cuando se bifurca.

Comencemos con la bifurcación en Ruby mirando un ejemplo alucinante:

```ruby
if fork
  puts "entered the if block"
else
  puts "entered the else block"
end

# outputs:
#
# => entered the if block
# => entered the else block
```

WTF! ¿Que está pasando aqui? Una llamada al método `fork` ha tomado la construcción if que alguna vez fue familiar y la ha puesto patas arriba. ¡De alguna manera, este fragmento de código ingresa tanto en el bloque if como en el else de la construcción if!

No es ningún misterio lo que está pasando aquí. Una llamada al método `fork` en realidad regresa dos veces. Recuerda que `fork` crea un nuevo proceso. Entonces regresa una vez en el proceso de llamada (padre) y una vez en el proceso recién creado (hijo).

El último ejemplo se vuelve más obvio si imprimimos los pids.

```ruby
puts "parent process pid is #{Process.pid}"

if fork
  puts "entered the if block from #{Process.pid}"
else
  puts "entered the else block from #{Process.pid}"
end
```

Salida:

```
parent process is 21268
entered the if block from 21268
entered the else block from 21282
```

Ahora queda claro que el proceso principal ejecuta el código en el bloque if, mientras que el proceso secundario ejecuta el código en el bloque else. Tanto el proceso hijo como el padre seguirán ejecutando el código después de la construcción if.

Una vez más, hay un ritmo en este ritmo y tiene que ver con el valor de retorno del método `fork`. **En el proceso hijo, `fork` devuelve `nil`**. Dado que `nil` es falso, ejecuta el código en el bloque else.

**En el proceso principal, `fork` devuelve el pid del proceso secundario recién creado**. Dado que un número entero es verdadero, ejecuta el código en el bloque if.

Este concepto se ilustra muy bien simplemente imprimiendo el valor de retorno de una llamada de bifurcación.

```ruby
puts fork

# outputs
# => 21423
# => nil
```

Aquí tenemos los dos valores de retorno diferentes. El primer valor devuelto es el pid del proceso secundario recién creado; esto viene del padre. El segundo valor devuelto es el cero del proceso hijo.

## ¿Programación multinúcleo?

De forma indirecta, sí. Al crear nuevos procesos, significa que su código puede, pero no está garantizado, distribuirse en múltiples núcleos de CPU.

Dado un sistema con 4 CPU, si bifurca 4 nuevos procesos, cada uno de ellos puede ser manejado por una CPU separada, lo que le brinda concurrencia multinúcleo.

Sin embargo, no hay garantía de que las cosas sucedan en paralelo. En un sistema ocupado, es posible que los 4 procesos sean manejados por la misma CPU.

> fork(2) crea un nuevo proceso que es una copia del proceso anterior. Entonces, si un proceso usa 500 MB de memoria principal, se bifurca, ahora tiene 1 GB en la memoria principal.
>
> Haga esto otras diez veces y podrá agotar rápidamente la memoria principal. Esto a menudo se llama `fork bomb`. Antes de aumentar la concurrencia, asegúrese de saber lo que hace.

## Usando un bloque

En el ejemplo anterior, hemos visto un `forka` con una construcción if/else. También es posible, y más común en Ruby, usar un `fork` con un bloque.

Cuando pasa un bloque al método `fork`, ese bloque se ejecutará en el nuevo proceso secundario, mientras que el proceso principal simplemente lo omite. El proceso hijo sale cuando termina de ejecutar el bloque. No continúa por la misma ruta de código que el padre.

```ruby
fork do
  # Code here is only executed in the child process
end

# Code here is only executed in the parent process.
```

## En el mundo real

Eche un vistazo a cualquiera de los apéndices, o al proyecto Spyglass adjunto, para ver algunos ejemplos del mundo real del uso de fork(2).

## Llamadas al sistema

`Kernel#fork` de Ruby se asocia a fork(2).

[<< back](README.md)
