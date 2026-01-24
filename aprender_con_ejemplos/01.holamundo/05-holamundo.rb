#!/usr/bin/env ruby

require "pastel"

print("Name: "); name = gets.chomp
print("Age: "); age = gets.to_i
print("Height: "); height = gets.to_f


pastel = Pastel.new

print "El personaje #{pastel.yellow.bold(name)}, "
print "tiene #{pastel.yellow.bold(age)} años de edad y "
puts "mide #{pastel.yellow.bold(height)} metros."
