#!/usr/bin/env ruby
require "pastel"
pastel = Pastel.new

# Pedir al usuario las coordenadas X e Y de dos puntos en el espacio
points = []

puts pastel.green "==> Introducir las coordenas (x,y)"
2.times do
  puts "Punto #{_1}:"
  print "  punto[#{_1}].x? "; x = gets.to_f
  print "  punto[#{_1}].y? "; y = gets.to_f
  point = [x, y]
  points << point
end

# Salida por pantalla
x0 = points[0][0]
y0 = points[0][1]
x1 = points[1][0]
y1 = points[1][1]

puts pastel.green "==> Salida por pantalla:"
puts "  Punto 0 (#{x0}, #{y0})"
puts "  Punto 1 (#{x1}, #{y1})"
