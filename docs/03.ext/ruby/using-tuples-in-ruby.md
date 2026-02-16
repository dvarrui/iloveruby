
# Using Tuples in Ruby?

> Enlace de la conversación original:
> * https://stackoverflow.com/questions/525957/using-tuples-in-ruby

## Consulta

¿Alguien usa tuplas en Ruby? Si es así, ¿cómo se puede implementar una tupla? Los hashes de Ruby están bien y funcionan casi igual, pero realmente querría tener algo como la clase `Tuple` de Python, donde puedes usar `.` para encontrar obtener cada valor. Es para poder crear una implementación de [D](https://www.amazon.com/dp/0321399420), similar a [Dee](https://www.quicksort.co.uk/) para Python.

## Respuesta

Puedes simular las tuplas usando `Struct`, además con el este truco podemos hacer que funcione la desestructuración (https://gist.github.com/stevecj/9ace6a70370f6d1a1511).


```ruby
Tuple = Struct.new(:_1, :_2)

t = Tuple.new("a", "b")
t._1 # => "a"
t._2 # => "b"

class Tuple
  def to_ary
    to_a
  end
end

a, b = t # => #<struct Tuple _1="a", _2="b">
a # => "a"
b # => "b"
```
