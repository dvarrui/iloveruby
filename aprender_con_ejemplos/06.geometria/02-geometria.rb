#!/usr/bin/env ruby

# Pedir al usuario las coordenadas X e Y de dos puntos en el espacio
points = []

puts "Introducir las coordenas (x,y)"
2.times do
  puts "  Punto #{_1}:"
  print "    x? "; x = gets.to_f
  print "    y? "; y = gets.to_f
  point = { x: x, y: y }
  points << point
end

# Salida por pantalla
puts "Salida por pantalla:"
puts "  Punto 0 (#{points[0][:x]}, #{points[0][:y]})"
puts "  Punto 1 (#{points[1][:x]}, #{points[1][:y]})"
