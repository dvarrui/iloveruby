#!/usr/bin/env ruby
# Clase

class Saludar
  def self.a(nombre = 'Mundo')
    puts "Hola #{nombre.capitalize}!"
  end
end

Saludar.a
Saludar.a "obiwan"
Saludar.a "YODA"
