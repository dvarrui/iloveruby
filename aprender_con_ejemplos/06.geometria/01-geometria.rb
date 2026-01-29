#!/usr/bin/env ruby

# Pedir al usuario las coordenadas X e Y de dos puntos en el espacio
points = []

puts "==> Introducir las coordenas (x,y)"
2.times do
  puts "Punto #{_1}:"
  print "  punto[#{_1}].x? "; x = gets.to_f
  print "  punto[#{_1}].y? "; y = gets.to_f
  point = { x: x, y: y }
  points << point
end

puts "DEBUG: #{points}"