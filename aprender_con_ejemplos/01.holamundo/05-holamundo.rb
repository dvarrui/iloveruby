#!/usr/bin/env ruby
require "pastel"

# Entrada de datos
print("Name: "); name = gets.chomp
print("Age: "); age = gets.to_i
print("Height: "); height = gets.to_f

# Salida por pantalla
pastel = Pastel.new

print "El personaje #{pastel.yellow.bold(name)}, "
print "tiene #{pastel.yellow.bold(age)} años de edad y "
puts "mide #{pastel.yellow.bold(height)} metros."
