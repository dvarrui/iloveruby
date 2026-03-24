# Paralelismo vs concurrencia

* Pros: crear sistemas escalables.
* Cons: Race conditions!

Paralelismo:
* Varias CPU's para el mismo problema.
* Los cálculos se realizan de manera simultánea (Mismo instante físico).

Concurrencia:
* Los cálculos se realizan de forma concurrente y no secuencial.
* Un proceso con varios.
* Los cálculos/hilos no ocurren en el mismo instante.

Procesos:
* Tienen zonas de memoria separadas.

Hilos:
* Comparten la zona de memoria, hay que sincronizar los accesos.

Comunicación:
* Zona de memoria compartida: Usar mutex, semáforos. Java y C# thread-safe
* Paso de mensajes: MPI, Go, Scala, Erlang, Ocam. Puede ser asíncrono o síncrono.

Dijkstra

# Ruby 

* Threads
* Process
* Ractors
* Fibers: más ligeros que un thread. Se pueden parar y reanudar.
# Async 
https://brunosutic.com/blog/async-ruby

