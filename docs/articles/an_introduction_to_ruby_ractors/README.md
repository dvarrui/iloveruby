[<< back](../README.md)

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

Los ractors envían mensajes a través de un puerto saliente y reciben mensajes a través de un puerto entrante. El puerto entrante puede contener un número infinito de mensajes y se ejecuta según el principio FIFO.

El método `.send` funciona de la misma manera que un cartero entrega un mensaje en el correo. El cartero toma el mensaje y lo deja caer en la puerta (puerto de entrada) del ractor.

Sin embargo, dejar caer un mensaje en la puerta de una persona no es suficiente para que la abra. Entonces `.receive` está disponible para que el ractor abra la puerta y reciba cualquier mensaje que se haya eliminado.

El ractor podría querer hacer un cálculo con ese mensaje y devolver una respuesta, entonces, ¿cómo lo obtenemos? Le pedimos al cartero que haga `.take` de la respuesta.

```ruby
tripple_number_ractor = Ractor.new do
  puts "I will receive a message soon"
  msg = Ractor.receive
  puts "I will return a tripple of what I receive"
  msg * 3
end
# I will receive a message soon
tripple_number_ractor.send(15) # mailman takes message to the door
# I will return a tripple of what I receive
tripple_number_ractor.take # mailman takes the response
# => 45
```

Como se vio anteriormente, el valor de retorno de un ractor también es un mensaje enviado y se puede recibir a través de `.take`. Dado que este es un mensaje saliente, va al puerto saliente.

Aquí hay un ejemplo simple:

```ruby
r = Ractor.new do
  5**2
end
r.take # => 25
```

Además de devolver un mensaje, un ractor también puede enviar un mensaje a su puerto saliente a través de `.yield`.

```ruby
r = Ractor.new do
  squared = 5**2
  Ractor.yield squared*2
  puts "I just sent a message out"
  squared*3
end
r.take
# => 50
r.take
# => 75
```

El primer mensaje enviado al puerto saliente es `square*2` y el siguiente mensaje es `square*3`. Por lo tanto, cuando llamamos a `.take`, obtenemos `50` la primera vez. Tenemos que llamar a `.take` una segunda vez para obtener `75` ya que se envían dos mensajes al puerto saliente.

Pongamos todo esto junto en un ejemplo de clientes que envían sus pedidos a un supermercado y reciben los pedidos cumplidos:

```ruby
supermarket = Ractor.new do
  loop do
    order = Ractor.receive
    puts "The supermarket is preparing #{order}"
    Ractor.yield "This is #{order}"
  end
end

customers = 5.times.map{ |i|
  Ractor.new supermarket, i do |supermarket, i|
    supermarket.send("a pack of sugar for customer #{i}")
    fulfilled_order = supermarket.take
    puts "#{fulfilled_order} received by customer #{i}"
  end
}
```

El resultado es el siguiente:

```
The supermarket is preparing a pack of sugar for customer 3
The supermarket is preparing a pack of sugar for customer 2
This is a pack of sugar for customer 3 received by customer 3
The supermarket is preparing a pack of sugar for customer 1
This is a pack of sugar for customer 2 received by customer 2
The supermarket is preparing a pack of sugar for customer 0
This is a pack of sugar for customer 1 received by customer 1
This is a pack of sugar for customer 0 received by customer 0
The supermarket is preparing a pack of sugar for customer 4
This is a pack of sugar for customer 4 received by customer 4
```

Ejecutarlo por segunda vez produce lo siguiente:

```
The supermarket is preparing a pack of sugar for customer 0
This is a pack of sugar for customer 0 received by customer 0
The supermarket is preparing a pack of sugar for customer 4
This is a pack of sugar for customer 4 received by customer 4
The supermarket is preparing a pack of sugar for customer 1
This is a pack of sugar for customer 1 received by customer 1
The supermarket is preparing a pack of sugar for customer 3
The supermarket is preparing a pack of sugar for customer 2
This is a pack of sugar for customer 3 received by customer 3
This is a pack of sugar for customer 2 received by customer 2
```

La salida definitivamente puede estar en un orden diferente cada vez que lo ejecutamos (porque los ractors se ejecutan simultáneamente).

Algunas cosas a tener en cuenta sobre el envío y la recepción de mensajes:
* Los mensajes también se pueden enviar usando `<< msg`, en lugar de `.send(msg)`.
* Se puede agregar una condición a `.receive` mediante `receive_if`.
* Cuando se llama a `.send` en un ractor que ya está terminado (no en ejecución), se obtiene un `Ractor::ClosedError`.
* El puerto saliente de un ractor se cierra después de que se llama a `.take` si se ejecuta solo una vez (no en un bucle).

```ruby
r = Ractor.new do
  Ractor.receive
end
# => #<Ractor:#61 (irb):120 running>
r << 5
# => #<Ractor:#61 (irb):120 terminated>
r.take
# => 5
r << 9
# <internal:ractor>:583:in `send': The incoming-port is already closed (Ractor::ClosedError)
r.take
# <internal:ractor>:694:in `take': The outgoing-port is already closed (Ractor::ClosedError)
```

Los objetos se pueden mover a un ractor de destino a través de `.send(obj, move: true)`  o `.yield(obj, move: true)`. Estos objetos se vuelven inaccesibles en el emisor, lo que genera un `Ractor::MovedError` cuando se intenta llamar a un método en los objetos movidos.

```ruby
r = Ractor.new do
  Ractor.receive
end
outer_object = "outer"
r.send(outer_object, move: true)
# => #<Ractor:#3 (irb):7 terminated>
outer_object + "moved"
# `method_missing': can not send any methods to a moved object (Ractor::MovedError)
```

Los threads no se pueden enviar como mensajes mediante `.send` y `.yield`. Al hacer esto, se produce un Error de tipo.

```ruby
r = Ractor.new do
  Ractor.yield(Thread.new{})
end
# <internal:ractor>:627:in `yield': allocator undefined for Thread (TypeError)
```

## Objetos que se pueden compartir y no compartir

Los objetos compartibles son objetos que se pueden enviar hacia y desde un ractor sin comprometer la seguridad del hilo. Un objeto inmutable es un buen ejemplo porque una vez creado, no se puede cambiar, por ejemplo, números y booleanos.

Se puede comprobar la compartibilidad de un objeto a través de `Ractor.shareable?` y hacer que un objeto se pueda compartir a través de `Ractor.make_shareable`.

```ruby
Ractor.shareable?(5)
# => true
Ractor.shareable?(true)
# => true
Ractor.shareable?([4])
# => false
Ractor.shareable?('string')
# => false
```

Como se vio anteriormente, los objetos inmutables son compartibles y los mutables no lo son. En Ruby, generalmente llamamos al método `.freeze` en una cadena para que sea inmutable. Este es el mismo método que los ractores aplican para hacer que un objeto sea compartible.

```ruby
str = 'string'
Ractor.shareable?(str)
# => false
Ractor.shareable?(str.freeze)
# => true
arr = [4]
arr.frozen?
# => false
Ractor.make_shareable(arr)
# => [4]
arr.frozen?
# => true
```

Los mensajes enviados a través de los ractors pueden ser compartibles o no compartibles. Cuando se puede compartir, se pasa el mismo objeto. Sin embargo, cuando no se puede compartir, los ractors realizan una copia completa del objeto de forma predeterminada y envían la copia completa en su lugar.

```ruby
SHAREABLE = 'share'.freeze
# => "share"
SHAREABLE.object_id
# => 350840
r = Ractor.new do
  loop do
    msg = Ractor.receive
    puts msg.object_id
  end
end
r.send(SHAREABLE)
# 350840
NON_SHAREABLE = 'can not share me'
NON_SHAREABLE.object_id
# => 572460
r.send(NON_SHAREABLE)
# 610420
```

Como se vio anteriormente, el objeto compartible es el mismo dentro y fuera del ractor. Sin embargo, el que no se puede compartir no se debe a que el ractor tenga un objeto diferente, solo idéntico a él.

Otro método para enviar un objeto exacto cuando no se puede compartir es el discutido anteriormente `move: true`. Esto mueve un objeto a un destino sin necesidad de realizar una copia.

**Algunas cosas a tener en cuenta sobre compartir objetos en ractors:**
* Los objetos Ractor también son objetos compartibles.
* Las constantes que son compartibles, pero definidas fuera del alcance de un ractor, pueden ser accedidas por un ractor. ¿Recuerde el ejemplo `outer_scope_object`? Pruebe de nuevo, definiendo `OUTER_SCOPE_OBJECT = "Soy un objeto de alcance externo".freeze`.
* Los objetos class y module se pueden compartir, pero las variables de instancia o las constantes definidas en ellos no lo son si se asignan valores no compartibles.

```ruby
class C
  CONST = 5
  @share_me = 'share me'.freeze
  @keep_me = 'unaccessible'
  def bark
   'barked'
  end
end

Ractor.new C do |c|
  puts c::CONST
  puts c.new.bark
  puts c.instance_variable_get(:@share_me)
  puts c.instance_variable_get(:@keep_me)
end
# 5
# barked
# share me
# (irb):161:in `instance_variable_get': can not get unshareable values from instance variables of classes/modules from non-main Ractors (Ractor::IsolationError)
```

* Un puerto entrante o un puerto saliente se pueden cerrar utilizando `Ractor#close_incoming` y `Ractor#close_outgoing`, respectivamente.

## Conclusión y lecturas adicionales sobre los ractores

En este artículo, presentamos el concepto de ractors, incluyendo cuándo y por qué usarlos y cómo comenzar. También analizamos cómo se comunican entre sí, qué objetos son compartibles y no compartibles, y cómo hacer que los objetos se puedan compartir.

Los ractors van más allá de esto. Muchos otros métodos públicos pueden ser llamados a los ractores, como `select` para esperar por el éxito de take, yield y receive, `.count`, `.current`, etc.

Para ampliar sus conocimientos sobre los ractors, consulte la [documentación del ractor](https://gist.github.com/Kukunin/960ccef0d3c0a2c4b28ff5345911c2a5). Este [GitHub gist](https://gist.github.com/Kukunin/960ccef0d3c0a2c4b28ff5345911c2a5) también podría interesarte si deseas comparar experimentalmente los ractors con los hilos.

Los ractors son de hecho experimentales, pero ciertamente parecen tener un futuro brillante en la evolución de Ruby.

Happy coding!
