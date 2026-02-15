
# Programación funcional en Ruby

> Functional Programming In Ruby (Complete Guide) Artículo original de Jesus Castello

Tal vez ha escuchado hablar sobre de la programación funcional y tiene algunas preguntas. Como:

* ¿Qué es exactamente la programación funcional?
* ¿Cómo se compara con la programación orientada a objetos?
* ¿Debería usar programación funcional en Ruby?

Voy a responder a estas preguntas para que puedas tener idea de cómo funciona.

## ¿Qué es la programación funcional?

No es una moda pasajera o una palabra elegante, es un paradigma de programación real que existe desde hace mucho tiempo, pero que ha recuperado popularidad recientemente.

Las ideas básicas detrás de este paradigma son más fáciles de entender de lo que imagina.

En la programación funcional **evitamos cambiar de estado** y tratamos de escribir **funciones** "puras".

Evitar el cambio de estado significa que las funciones no cambian nada fuera de la función, no hay variables de instancia, y no se cambian los objetos que se pasen...

¡Nada de eso!

En un lenguaje de programación funcional (como [Haskell](https://www.haskell.org/)) todos los datos son INMUTABLES.

Hay variables, pero se comportan más como en el mundo matemático. Una vez que se le da un valor a una variable, el compilador no le permitirá redefinir esta variable con otro valor.

## Beneficios de la programación funcional

La inmutabilidad es la principal ventaja de la programación funcional porque los datos mutables pueden provocar errores sutiles que son difíciles de rastrear.

```ruby
def all_different_from_first?(arr)
  first = arr.shift
  arr.all? { |n| n != first }
end

arr = [1,3,5,7,9]
p all_different_from_first?(arr)
# => true
```

En este ejemplo, queremos averiguar si todos los elementos de la matriz son diferentes del primer elemento.

Para que funcione, debemos eliminar el primer elemento de la matriz y, al mismo tiempo, guardar este elemento para que podamos compararlo con el resto.

**¿Cómo podemos hacerlo?**

Estamos trabajando con un Array, y si observa la lista de métodos disponibles, encontrará que el método `Array#shift` hace exactamente lo que queremos.

Funciona bien hasta que... leemos el valor de `arr` después de invocar al método:

```ruby
all_different_from_first?(arr)
# => true
arr
# => [3,5,7,9]
```

_¡Sorpresa!_ La matriz perdió un elemento (1) y no nos dimos cuenta. Así de astutos pueden ser este tipo de errores de mutabilidad.

**Versión fija:**

```ruby
def all_different_from_first?(arr)
  arr[1..-1].all? { |n| n != arr.first }
end
```

## Funcional vs OOP

_¿Deberíamos todos adoptar la programación funcional?_

Puede parecer que los estados inmutables hace que la programación funcional sea completamente opuesta a la programación orientada a objetos, y en cierto sentido lo es, pero todavía hay una manera en que **los dos paradigmas de programación pueden trabajar juntos**.

Así que no, no hay necesidad de apresurarse e ir completamente a la programación funcional. Ruby está diseñado para programación orientada a objetos de todos modos, por lo que estarías luchando contra la corriente.

**Las buenas noticias:** Se pueden usar las mejores ideas de la programación funcional y aplicarlas a su código Ruby

Veamos cómo.

## Reduzca la mutabilidad tanto como sea posible

Una forma de hacerlo es DEJAR de usar `attr_accessor`, ceñirse solo a `attr_reader`.

Después de hacer eso, debe vigilar las cadenas, matrices y hashes. Hay métodos que cambiarán estos objetos:
* La mayoría de los métodos que terminan en ! (como `gsub!`)
* `delete`
* `update`
* `clear`
* `shift` / `unshift` / `pop` / `push`

El primer paso es ser consciente de estos métodos. Si tiene que usar uno de estos métodos, puede trabajar en un objeto duplicado.

Dada una cadena y un clon de esa cadena. Aunque borremos la cadena duplicada, la cadena original se mantiene segura:

```ruby
str = "abcd"
dup = str.dup

dup.clear
# str => "abcd"
# dup => ""
```

## Aplicación parcial

Hay más cosa en la programación funcional aparte de datos inmutables y funciones puras. Como por ejemplo, la aplicación parcial de funciones, también conocida como “currying”.

Ejemplo:

```ruby
def add(a,b)
  a + b
end

add_five = method(:add).curry[5]

add_five.call(5)
# => 10
add_five.call(20)
# => 25
```

El método `add` toma dos argumentos, pero al usar el método `curry` podemos "precargar" uno de los argumentos. Luego obtenemos una lambda a la que podemos llamar con solo el segundo argumento. Veamos otro ejemplo:

```ruby
list = (1..10)

greater_than = ->(x,y) { y > x }.curry

list.select(&greater_than.(5))
# => [6, 7, 8, 9, 10]
list.select(&greater_than.(8))
# => [9, 10]
```

Otro ejemplo:

```ruby
divisible_by = ->(x,y) { y % x == 0 }.curry

list.select(&divisible_by.(5))
# => [5, 10]
list.select(&divisible_by.(2))
# => [2, 4, 6, 8, 10]
```

## Resumen

Sobre programación funcional hemos aprendido que:
* El núcleo son las funciones puras y los datos inmutables.
* Es solo una forma de pensar sobre el código y no es completamente incompatible con OOP.
