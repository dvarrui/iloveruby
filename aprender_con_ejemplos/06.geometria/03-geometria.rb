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
  point = { x: x, y: y }
  points << point
end

# Salida por pantalla
puts pastel.green "==> Salida por pantalla:"
puts "  punto[0] (#{points[0][:x]}, #{points[0][:y]})"
puts "  punto[1] (#{points[1][:x]}, #{points[1][:y]})"

# Mostrar por pantalla la distancia en línea recta entre esos dos puntos
x0 = points[0][:x]
y0 = points[0][:y]
x1 = points[1][:x]
y1 = points[1][:y]
distance = Math.sqrt((x1 - x0)**2 + (y1 - y0)**2)

puts "La distancia es: #{distance}"
