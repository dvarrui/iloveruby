#!/usr/bin/env ruby

# A. Entrada de datos con gets
print("Name: "); name = gets.chomp
print("Age: "); age = gets.to_i
print("Height: "); height = gets.to_f

# B. Salida por pantalla
puts "El personaje #{name}, tiene #{age} años de edad y mide #{height} metros."
