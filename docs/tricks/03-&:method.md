
# Cómo funciona `&:method` entre bastidores

> URL: https://twitter.com/ak_rails/status/1580177106582896640?t=s3LPlhamb03jK6ONWy5pNQ&s=35
> Akshay, @ak_rails

Probablemente ya conozca el atajo `&:method` de Ruby.

A partir de un argumento nombre de un método como un símbolo con el prefijo de un operador `&`, Ruby tratará de invocar a dicho método. En el siguiente ejemplo, Ruby llama a `length` en cada elemento.

```ruby
items = ['hi', 'hello']
items.map(&:lenght) #=> [2, 5]

(1..3).map(&:to_s) #=> ["1", "2", "3"]
```

## Veamos cómo funciona esto por dentro.

Cuando antepone el operador `&` a un argumento de método, se llama a `to_proc` en su operando y pasa el resultado como un bloque.

Puede anular el método `to_proc` para devolver un bloque personalizado como lo hace la clase `Person` a continuación.

```ruby
def bar(&block)
  block.call
end

class Person
  def self.to_proc
    -> { puts "Hello World!" }
    # Proc.new { puts "Hello World!" }
    # proc { puts "Hello World!" }
  end
end

bar(&Person) #=> "Hello World!"
```

Ahora, cambiemos la clase `Symbol` para agregar un método `to_proc`. Devolverá un proc/lambda que llama al símbolo (self) en su argumento (elemento), utilizando el método `send`.

```ruby
class Symbol
  def to_proc
    -> (item) { item.send self }
  end
end
```

> Recordar que todos los símbolos (por ejemplo, `:item`) son instancias de Symbol.

Ahora, cuando pasa `&:some_method` por argumento a un método que acepta un proceso, se invoca a `some_method`. De modo que las dos llamadas siguientes son equivalentes:

```ruby
items = ['hi', 'hello']
items.map(&:lenght) #=> [2, 5]
items.map { |item| item.send :to_s } #=> [2, 5]
```

La buena noticia es que no tenemos que parchear Symbol para agregar este método. Ruby ya lo hace. Este acceso directo se agregó en ActiveSupport y se hizo oficial en Ruby 1.8.7.

> Consulte https://ruby-doc.org/core-3.1.1/Symbol.html#method-i-to_proc

_Espero que lo hayas encontrado útil. Avísame si me perdí algo (@ak_rails)_
