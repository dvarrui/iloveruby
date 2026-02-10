#!/usr/bin/env ruby
# Ejemplo: Clase Perro y objeto snoopy

class Perro
  def initialize(name)
    @name = name
  end
  
  def ladrar()
    return "[#{@name}] Guau!"
  end
end
  
snoopy = Perro.new("Snoopy")
puts(snoopy.ladrar())  #=>[Snoopy] Guau!
``` 
