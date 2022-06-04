[<<back](README.md)

# Programación Orientada a Objetos

Vamos a ver la POO de Ruby en varios niveles.

# POO clásica.

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
