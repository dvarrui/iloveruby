
# Introdución a Ruby Ractors (traducido)

> Enlace al artículo original:
> * https://blog.appsignal.com/2022/08/24/an-introduction-to-ractors-in-ruby.html

En esta publicación, nos sumergiremos en los ractors de  Ruby, explorando cómo construir un ractor. Veremos cómo enviar y recibir mensajes en los ractors, y aprenderemos sobre los objetos que se pueden compartir y los que no. Pero primero, definamos el modelo de actor y los ractors, y consideremos cuándo se deben usar los ractors.

## ¿Qué es el modelo de actor?

En informática, el modelo orientado a objetos es muy popular, y en la comunidad de Ruby, muchas personas están acostumbradas al término "todo es un objeto".

Del mismo modo, permítanme presentarles el modelo de actor, dentro del cual "todo es un actor". El modelo de actor es un modelo matemático de computación concurrente en el que el agente primitivo/fundamental universal de la computación es un actor. Un actor es capaz de lo siguiente:
* Recibir mensajes y responder al remitente
* Envío de mensajes a otros actores
* Determinar cómo responder al siguiente mensaje recibido
* Creación de varios otros actores
* Tomar decisiones locales
* Realizar acciones (por ejemplo, mutar datos en una base de datos)

Los actores se comunican a través de mensajes, procesan un mensaje a la vez y mantienen su propio estado privado. Sin embargo, pueden modificar este estado a través de los mensajes recibidos, eliminando la necesidad de un bloqueo o mutex.

Los mensajes recibidos se procesan un mensaje a la vez en el orden FIFO (primero en entrar, primero en salir). El remitente del mensaje está desacoplado (aislado) de la comunicación enviada, lo que permite la comunicación asincrónica.

Algunos ejemplos de la implementación del modelo de actor son akka, elixir, pulsar, celuloide y **ractors**. Algunos ejemplos de modelos de simultaneidad incluyen threads, process y futures.

## ¿Qué son los ractors en Ruby?

Ractor es una abstracción actor-modelo que proporciona una función de ejecución paralela sin las preocupaciones de [seguridad en los thread](https://hacks.mozilla.org/2019/02/fearless-security-thread-safety/).

 Al igual que los hilos, los ractors proporcionan un verdadero paralelismo. Sin embargo, a diferencia de los hilos, no lo comparten todo. La mayoría de los objetos no se pueden compartir y, cuando se pueden compartir, están protegidos por un intérprete o mecanismo de bloqueo. Los ractors tampoco pueden acceder a ningún objeto a través de variables no definidas dentro de su alcance. Esto significa que podemos estar libres de la posibilidad de [condiciones de carrera](https://www.techtarget.com/searchstorage/definition/race-condition).

> NOTA DEL TRADUCTOR: En algunos artículos se dice que los threads no implementan un verdadero paralelismo puesto que no pueden haber dos threads en ejecución simultáneamente.

En 2020, cuando se lanzó Ruby 3.0.0, estas fueron las [palabras de Matz](https://www.ruby-lang.org/en/news/2020/12/25/ruby-3-0-0-released/):

> _Estamos en la era multinúcleo. La concurrencia es muy importante. Con Ractor, junto con Async Fiber, Ruby será un verdadero lenguaje concurrente._

Los ractores no afirman haber resuelto todos los problemas de seguridad de los hilos. En la [documentación de Ractor](https://docs.ruby-lang.org/en/3.0/ractor_md.html), se indica claramente lo siguiente:

> _"Hay varias operaciones de bloqueo (espera de envío, espera de rendimiento y espera de toma) para poder crear un programas con problemas de dead-lock y live-lock"_.
>
> _"Algunos tipos de objetos compartibles puede introducir transacciones (STM, por ejemplo). Sin embargo, el uso indebido de las transacciones generará un estado inconsistente."_

Sin ractors, se deben rastrear todos los cambios de estado para depurar los problemas de thread-safety. Sin embargo, la belleza de los ractors es que podemos concentrar el esfuerzo en el código compartido sospechoso.

## ¿Cuándo y por qué debemos usar ractors en Ruby?

Cuando creamos un ractor por primera vez, recibiremos un aviso como éste:

```
<internal:ractor>:267: warning: Ractor is experimental, and the behavior may change in future versions of Ruby! Also there are many implementation issues.
```

Sin embargo, eso no significa que debamos evitar el uso de ractors. Debido a la ejecución paralela, los ractores pueden completar procesos mucho más rápido que cuando los procesos se llevan a cabo sincrónicamente.

En las notas de la versión de Ruby 3.0.0, encontraremos este ejemplo de referencia de la [función Tak](https://www.ruby-lang.org/en/news/2020/12/25/ruby-3-0-0-released/), donde se ejecuta secuencialmente cuatro veces y cuatro veces en paralelo con los ractores:

```ruby
def tarai(x, y, z) =
  x <= y ? y : tarai(tarai(x-1, y, z),
                     tarai(y-1, z, x),
                     tarai(z-1, x, y))
require 'benchmark'
Benchmark.bm do |x|
  # sequential version
  x.report('seq'){ 4.times{ tarai(14, 7, 0) } }

  # parallel version with ractors
  x.report('par'){
    4.times.map do
      Ractor.new { tarai(14, 7, 0) }
    end.each(&:take)
  }
end
```

Los resultados son los siguientes:
```
Benchmark result:
          user     system      total        real
seq  64.560736   0.001101  64.561837 ( 64.562194)
par  66.422010   0.015999  66.438009 ( 16.685797)
```

Las [notas de la versión de Ruby 3.0.0](https://www.ruby-lang.org/en/news/2020/12/25/ruby-3-0-0-released/) indican:

> _"El resultado se midió en Ubuntu 20.04, Intel(R) Core(TM) i7-6700 (4 núcleos, 8 hilos de hardware). Vemos que la versión paralela es 3,87 veces más rápida que la versión secuencial."_

Por lo tanto, si necesitamos un tiempo de ejecución de procesos más rápido que pueda ejecutarse en paralelo en máquinas con múltiples núcleos, los ractors no son una mala idea en absoluto.

La modificación de objetos de clase/módulo en programas multi-ractor puede introducir condiciones de carrera y debe evitarse tanto como sea posible. Sin embargo, la mayoría de los objetos no se pueden compartir, por lo que la necesidad de implementar bloqueos para evitar las condiciones de carrera se vuelve obsoleta. Si los objetos son compartibles, están protegidos por un intérprete o mecanismo de bloqueo.

## Creando tu primer ractor en Ruby

Crear un ractor es tan fácil como crear cualquier instancia de clase. Llama a `Ractor.new` con un bloque - `Ractor.new { block }`. Este bloque se ejecuta en paralelo con cualquier otro ractor.

_Es importante tener en cuenta que cada ejemplo mostrado a partir de este punto se realizó en Ruby 3.1.2._

```ruby
r = Ractor.new { puts "This is my first ractor" }
# This is my first ractor

# create a ractor with a name
r = Ractor.new name: 'second_ractor' do
  puts "This is my second ractor"
end
# This is my second ractor

r.name
# => "second_ractor"
```

Los argumentos también se pueden pasar a `Ractor.new`, y estos argumentos se convierten en parámetros para el bloque del ractor.

```ruby
my_array = [4,5,6]
Ractor.new my_array do |arr|
  puts arr.each(&:to_s)
end
# 4
# 5
# 6
```

¿Recuerdas que dijimos que los ractores no pueden acceder a objetos definidos fuera de su alcance? Veamos un ejemplo:

```ruby
outer_scope_object = "I am an outer scope object"
Ractor.new do
  puts outer_scope_object
end
# <internal:ractor>:267:in `new': can not isolate a Proc because it accesses outer variables (outer_scope_object). (ArgumentError)
```

Obtenemos un error en la invocación de `.new`, relacionado con un `Proc` que no está aislado. Esto se debe a que `Proc#isolate` se llama a la creación de un ractor para evitar compartir objetos no compartibles. Sin embargo, los objetos se pueden pasar hacia y desde los ractors a través de mensajes.

## Envío y recepción de mensajes en ractors
