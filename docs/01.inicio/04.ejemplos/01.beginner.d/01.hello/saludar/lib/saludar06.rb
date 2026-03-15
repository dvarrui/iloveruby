
require 'colorize'

class Saludar
  def self.a(nombre = 'Mundo')
    puts "¡Hola #{nombre}!"
  end

  def self.to(name = 'World')
    puts "Hello #{name}!".light_red
  end

  def self.gritando(name = 'Mundo')
    puts "¡Hola #{name}!".upcase
  end

  def self.flojito(nombre = 'Mundo')
    puts "¡Hola #{nombre}!".downcase.white
  end
end
