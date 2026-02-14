#!/usr/bin/env ruby
require "pastel"

# A. Entrada de datos con gets
print("Name: "); name = gets.chomp
print("Age: "); age = gets.to_i
print("Height: "); height = gets.to_f

# Ponemos color a las variables
pastel = Pastel.new
colored_name = pastel.yellow.bold(name.capitalize)
colored_age = pastel.yellow.bold(age)
colored_height = pastel.yellow.bold(height)

# B. Salida por pantalla
print "El personaje #{colored_name}, "
print "tiene #{colored_age} años de edad y "
puts "mide #{colored_height} metros."
