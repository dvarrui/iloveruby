[<< back](../../../README.md)

# 12 ways to call a method in Ruby (traducido)

https://www.notonlycode.org/12-ways-to-call-a-method-in-ruby/

**12 formas de llamar a un método en Ruby** es un pequeño y divertido experimento en el vamos a llamar al mismo método en Ruby de tantas maneras como sea posible.

```
Gregorio Witek
13 de agosto de 2020 • 5 minutos de lectura
```

Hoy, durante una conversación con uno de mis colegas, discutimos como acordar la forma de escribir nuestro código Python. Bromeamos acerca de cómo Python sigue esta idea de tener exactamente una forma de hacer cada cosa (que generalmente sigue el lenguaje, pero no necesariamente las bibliotecas). Me hizo pensar en Ruby, que tiene una filosofía opuesta: todo se puede hacer de muchas maneras diferentes.

Esto me llevó a una idea aleatoria de verificar de cuántas maneras diferentes puedo llamar a un solo método en Ruby. Terminé con 12 formas diferentes (un par son un poco engañosas). Prepárese para algunas sorpresas a continuación, ¡especialmente la última es alucinante!

**Advertencia**, el código a continuación no está diseñado para usarse en producción (especialmente los últimos 3 ejemplos). Es solo mi exploración de las capacidades del lenguaje. Algunas de las técnicas que se muestran son útiles en un montón de casos, pero asegúrese de proceder con precaución. La simplicidad, la seguridad y la legibilidad son más importantes que las cosas sofisticadas.

## Configuración

Por el bien de este experimento, estoy configurando una sola clase con un método que llamaré de muchas maneras diferentes. En aras de la simplicidad, el método no acepta argumentos (aunque creo que cada ejemplo también funcionaría con argumentos).

La clase se llama `User`, tiene 1 atributo, `name`, y el método a llamar es `hello`, el cual imprime un mensaje de bienvenida, incluyendo el nombre de usuario.

```ruby
class User
  def initialize(name)
    @name = name
  end

  def hello
    puts "Hello, #{@name}!"
  end

  def method_missing(_)
    hello
  end
end

user = User.new('Gregory')
```

## 1: la manera obvia

```ruby
user.hello()
```

No hay mucho que ver aquí: así es como se llaman a los métodos en muchos lenguages. Dato interesante: puedes poner espacios alrededor del punto: `user . hello()` también funcionará.


## 2: saltar los corchetes

```ruby
user.hello
```

Técnicamente funciona igual que el anterior, simplemente se omiten los corchetes, que son opcionales en Ruby (siempre que el código no sea ambiguo, a veces son necesarios debido a las múltiples formas en que se puede analizar el código).

## 3-4: usando `send` y `public_send`

```ruby
user.send(:hello)
user.public_send(:hello)
```

En este caso, pasamos el nombre de la función a llamar como argumento a los métodos `send` o `public_send` que están definidos en cada clase. La diferencia entre `send` y `public_send` es que este último respeta la privacidad de los métodos: si intenta llamar al método privado, generará un error, mientras que `send` aún lo llamará.

Estoy pasando el nombre de la función usando el tipo de símbolo (`:hello`), pero también puedes usar una cadena (`"hello"`).

## 5-7: usando "method" y "call"

```ruby
user.method(:hello).call
user.method(:hello).()
user.method(:hello)[]
```

3 ejemplos, siendo el segundo y el tercero solo un _syntax sugar_, por eso se han puesto juntos. Este es bastante interesante. Llamar a `user.method(:hello)` devuelve una instancia de la clase `Method`. Este objeto se puede pasar como cualquier valor y se puede llamar en cualquier momento; también almacena la referencia al objeto al que pertenece, por lo que si cambio el nombre del usuario, se usará el nuevo:

```ruby
method = user.method(:hello)
user.set_instance_variable(:@name, "Not Only Code")
method.call() # prints "Hello, Not Only Code!"
```

`.()` y `[]` son equivalentes a `.call()` y también pueden recibir argumentos: `proc.call(1,2,3)`, `proc.(1,2,3)` y `proc[1,2,3]` todos funcionan de la misma manera (aunque el último no admitirá argumentos con nombre).

## 8: usando "tap"

```ruby
user.tap(&:hello)
```

`tap` es un pequeño y divertido método que toma un bloque, se pasa a sí mismo como un argumento y ejecuta el bloque, y finalmente se devuelve a sí mismo. Raramente lo uso, pero hay casos en los que podría ser útil (como efectos secundarios al encadenar métodos).

La sintaxis `&:hello` convierte el símbolo `:hello` en una instancia de `Proc`. Puede leer más sobre esta sintaxis en el [blog de Honeybadger](https://www.honeybadger.io/blog/how-ruby-ampersand-colon-works/); allí se explica muy bien. `Proc` es un objeto que se puede invocar, al igual que `Method` de los ejemplos anteriores.

> **NOTA DEL TRADUCTOR**: Más información sobre [tap](https://medium.com/aviabird/ruby-tap-that-method-90c8a801fd6a)

## 9: usando "to_proc" en el nombre de la función

```ruby
:hello.to_proc.call(user)
```

Me gusta este porque invierte el orden: el usuario se convierte en el argumento de la función. Lo que sucede debajo del capó aquí es muy similar al anterior: la función de llamada de `Proc` pasa el símbolo inicial al argumento recibido. Algo parecido a esto:

```ruby
class Proc
  def call(obj)
    obj.send(@symbol_used_to_create_proc)
  end
end
```

## 10: usando "method_missing"

```ruby
class User
  def method_missing(_)
    hello
  end
end

user.i_am_a_lizard_king  # prints "Hello, Gregory!"
user.i_can_do_everything # prints "Hello, Gregory!"
```

Este es un poco engañoso, ya que aún bajo el capó se utiliza la forma estándar de llamar a un método, pero creo que vale la pena ponerlo aquí.

`method_missing` es un método que se ejecutará cuando el objeto reciba una llamada a un método que no está definido. Es una función poderosa que es uno de los fundamentos de la flexibilidad de Ruby, sin embargo, puede generar errores que tardan años en encontrar (y algunos problemas de rendimiento), así que utilícelo con precaución.

## 11: usando "eval"

```ruby
eval("usser.hello")
```

Nuevamente, un poco de trampa, ya que sigo usando la sintaxis de llamada de método estándar, pero la forma en que funciona bajo el capó es obviamente muy diferente. `eval` pasa la cadena al analizador e intérprete de Ruby como si fuera parte de mi código y luego ejecuta el código. Definitivamente, debe evitar absolutamente usarlo en su código, especialmente si permite que los usuarios pasen algunos valores a su aplicación.

## 12: using "source" and "instance_eval"

```ruby
require 'method_source' # external gem

method_source = user.method(:hello).source
method_body = method_source.split("\n")[1...-1].join(";")
user.instance_eval(method_source)
```

Ok, el último, y es bastante loco, por lo que la explicación es un poco más larga. Se basa en una gema externa, llamada `method_source`, pero eso se debe a que me llevaría demasiado tiempo y espacio escribir este código aquí (aunque todo es Ruby, ¡sin magia!). Déjame explicarte cómo funciona:

`user.method(:hello).source` devuelve la fuente del método como una cadena. La salida de esto es todo el cuerpo (incluidos los espacios):

```ruby
  def hello
    puts "Hello, #{@name}!"
  end
```

¿Cómo lo hace la gema `method_source`? La clase `Method` en Ruby tiene una función `source_location` que devuelve la ubicación del código fuente del método: archivo y número de línea donde comienza el método. Entonces `method_source` esencialmente abre ese archivo, encuentra la línea respectiva, busca el final que finalizará el método y devuelve el código intermedio.

Ahora que tengo el código completo del método, quiero eliminar la definición del método y el final. En mi caso, solo elimino la primera y la última línea, pero si el método fuera de una sola línea, requeriría algunos cambios. La salida de la segunda línea es una cadena con valor: `puts "Hello, #{@name}!"`.

Finalmente, tomo esta cadena y la paso a `instance_eval` de mi objeto `user`. `instance_eval` funciona como `eval` excepto que ejecuta código en un ámbito diferente. Si llamo a `eval`, ejecutaría el código en el alcance de todo mi archivo, donde la variable `@name` no está definida. Al pasarlo a `instance_eval`, me aseguro de que use los valores correctos.

## ¿Hay más?

Ese fue un pequeño experimento divertido. Estoy bastante seguro de que hay más formas de llamar a los métodos en Ruby: es un lenguaje grande y muy flexible. Si conoces otras formas, házmelo saber, ¡tengo mucha curiosidad!

Y si disfruta de mi contenido, consulte mi canal de [YouTube, Not Only Code](https://www.youtube.com/channel/UCj3PDQ-4n9sO0j3t2j608WQ), donde hablo sobre diferentes aspectos del trabajo como desarrollador de software.

La discusión sobre esta publicación de blog (y algunas otras adiciones a la lista) se puede encontrar en [Ruby Subreddit](https://www.reddit.com/r/ruby/comments/i9hvjj/12_ways_to_call_a_method_in_ruby/?utm_source=share&utm_medium=web2x&context=3).
