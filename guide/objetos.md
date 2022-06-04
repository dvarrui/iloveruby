[<<back](README.md)

# Programación Orientada a Objetos

Vamos a ver la POO de Ruby en varios niveles.

# Clase

Una clase es una especie de "plantilla" en la que se definen los atributos y métodos predeterminados de un tipo de objeto. Esta plantilla se crea para poder crear objetos fácilmente. Al método de crear nuevos objetos mediante la lectura y recuperación de los atributos y métodos de una clase se le conoce como instanciación.

> Los atributos de una instancia de clase de escriben con "@" al principio. Por ejemplo `@name`. Los métodos/funciones de clase se definen dentro de la clase con `def`, igual que cualquier método/función.

```ruby
class Person
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def to_s
    "Hi! I'm a Person and my name is #{@name}"
  end
end

obiwan = Person.new("Obi-wan")

puts obiwan.name
puts obiwan
```

## Herencia

Herencia de la clase `Person` a la clase `Jedi`, es la facilidad mediante la cual la clase `Jedi` hereda en ella cada uno de los atributos y operaciones de `Person`, como si esos atributos y operaciones hubiesen sido definidos por la misma `Jedi`.

```ruby
#!/usr/bin/env ruby

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Jedi < Person
  def greet
    "I'm Jedi, #{@name}"
  end
end

class Sith < Person
  def greet
    "I'm Lord #{@name}"
  end
end

obiwan = Jedi.new("Obi-wan")
vader = Sith.new("Vader")

puts obiwan.greet
puts vader.greet
```

## Ocultación

Cuando usamos una instancia de una clase, podemos usar los métodos y variables registrados como "públicos". En Ruby por defecto: todos los métodos/funciones son públicos, y todos los atributos por defecto son privados.

Los componentes registrados como "privados" (private) mantienen escondidos al programador y solo pueden ser accedidos a través de otros métodos públicos.
