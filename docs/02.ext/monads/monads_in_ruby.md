[<< back](../README.md)

# Monads in Ruby - Karl Brodowsky's IT-Blog (traducido)

> Enlace original:
> * https://brodowsky.it-sky.net/2015/01/23/monads-in-ruby/

2015-01-23

## ¿Mónadas? ¡Fácil!

Una [Mónada](https://es.wikipedia.org/wiki/M%C3%B3nada_(programaci%C3%B3n_funcional)) sobre X es simplemente un Monoide en la Categoría de Endofuntores de X.

## ¿Mónadas? ¡En realidad!

* Las mónadas son un concepto en matemáticas.
* El álgebra es un área de las matemáticas.
* La teoría de categorías es una abstracción del álgebra.
* Las mónadas se definen en la teoría de categorías.
* Recuerda: en la teoría de categorías hablamos de infinito más allá de la cardinalidad de conjuntos infinitos...
* La "idea" ha sido trasplantada a algo usado en lenguajes de programación...
* Solo piense en las estrellas en términos de astronomía, en términos de decoración y en términos de música o películas.

## Mónada como patrón de diseño

* En realidad, las mónadas deben verse como un patrón de diseño.
* Eso describe el nivel de abstracción.

## Motivación

* Los programadores funcionales puros son pobres cuando se trata de estado
* El estado es malo
* Estado no es posible o difícil
* I/O es estado, en realidad se manipula un segmento del mundo exterior
* Las mónadas encapsulan eso
* Incluso si está satisfecho con el estado (pobre teología de TI...):
* Problema de multinivel nulo 🙁

## Mónadas en Programación Funcional

* Tipo de contenedor
* Envolver (foo):
    * método de clase
    * también se puede llamar `unit`
    * Por cierto. los arrogantes chicos de Haskell lo llaman `return`
* Pasar(&bloque)
    * Método de instancia
    * También se puede llamar `bind`
    * Opcionalmente más operaciones (mjoin, vacío, +,…)

## Mónada de identidad

```ruby
class Identity
  def initialize(value)
    @value = value
  end
end

def Identity.wrap(value)
  new(value)
end

class Identity
  def pass
    yield @value
  end
end
```

> **NOTA DEL TRADUCTOR**:
> Otra forma de escribir lo mismo
> ```ruby
class Identity
  def initialize(value)
    @value = value
  end
  def self.wrap(value)
    class.new(value)
  end
  def pass
    yield @value
  end
end
> ```

## Axiomas

* _Left-identity_ para `pass`: Llamar a `pass` a un nuevo valor recién aplicado el método `wrap` es lo mismo que aplicar el bloque directamente al valor.

> **NOTA DEL TRSADUCTOR**
> ```ruby
Identity.wrap("obiwan").pass { block } # => block("obiwan")
> ```

* _Right-identity_ para `pass`: Llamar a `pass` con un bloque que solo llama a `wrap` da como resultado el mismo objeto.

> **NOTA DEL TRADUCOTR**
> ```ruby
jedi = Identity.wrap("obiwan")
jedi.pass { wrap } # => Identity.wrap("obiwan")
> ```

* Anidamiento: Anidar bloques con `pass` debería ser equivalente a llamarlos en secuencia.
