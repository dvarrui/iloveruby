#!/usr/bin/env ruby
# Valor por defecto

def saludar_a(nombre = "MUNDO")
  puts "Hola #{nombre.capitalize}!"
end

saludar_a
saludar_a "david"
