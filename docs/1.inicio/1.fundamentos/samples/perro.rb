#!/usr/bin/env ruby
# Ejemplo: Clase Perro
class Perro
  # Este es el constructor de las intancias
  def initialize(name)
    @name = name
  end

  # Método de instancia (Los paréntesis no son necesarios si no hay argumentos)
  def ladrar
    title + " Guau!"
  end

  private

  def title
    "[#{@name}]"
  end
end

# Ejemplo: objeto snoopy
snoopy = Perro.new("Snoopy")
puts snoopy.ladrar
