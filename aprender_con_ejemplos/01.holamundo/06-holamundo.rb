#!/usr/bin/env ruby
require "pastel"
require "tty-prompt"

# Entrada de datos con tty-prompt
prompt = TTY::Prompt.new

name = prompt.ask("Name?", default: "Obiwan")
age = prompt.ask("Age?", default: 57)
height = prompt.ask("height?", default: 1.8)

# Ponemos color a las variables
pastel = Pastel.new
colored_name = pastel.yellow.bold(name.capitalize)
colored_age = pastel.yellow.bold(age)
colored_height = pastel.yellow.bold(height)

# Salida por pantalla
print "El personaje #{colored_name}, "
print "tiene #{colored_age} años de edad y "
puts "mide #{colored_height} metros."
