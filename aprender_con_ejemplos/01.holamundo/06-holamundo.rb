#!/usr/bin/env ruby
require "pastel"
require "tty-prompt"

# Entrada de datos
prompt = TTY::Prompt.new

name = prompt.ask("Name?", default: "Obiwan")
age = prompt.ask("Age?", default: 57)
height = prompt.ask("height?", default: 1.8)

# Salida por pantalla
pastel = Pastel.new

print "El personaje #{pastel.yellow.bold(name)}, "
print "tiene #{pastel.yellow.bold(age)} años de edad y "
puts "mide #{pastel.yellow.bold(height)} metros."
