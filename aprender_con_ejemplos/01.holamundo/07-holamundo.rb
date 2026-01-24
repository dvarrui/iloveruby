#!/usr/bin/env ruby
require "pastel"

# Entrada de datos por argumentos
name = ARGV[0]
age = ARGV[1].to_i
height = ARGV[2].to_f

# Ponemos color a las variables
pastel = Pastel.new
colored_name = pastel.yellow.bold(name.capitalize)
colored_age = pastel.yellow.bold(age)
colored_height = pastel.yellow.bold(height)

# Salida por pantalla
print "El personaje #{colored_name}, "
print "tiene #{colored_age} años de edad y "
puts "mide #{colored_height} metros."
