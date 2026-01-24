#!/usr/bin/env ruby
require "pastel"

# Entrada de datos por argumentos
name = ARGV[0]
age = ARGV[1].to_i
height = ARGV[2].to_f
mts = height.to_i
cms = ((height % mts) * 100).round(0)

# Ponemos color a las variables
pastel = Pastel.new
colored_name = pastel.yellow.bold(name.capitalize)
colored_age = pastel.yellow.bold(age)
colored_mts = pastel.yellow.bold(mts)
colored_cms = pastel.yellow.bold(cms)

# Salida por pantalla
print "El personaje #{colored_name}, "
print "tiene #{colored_age} años de edad y "
puts "mide #{colored_mts} metros y #{colored_cms} centímetros"
