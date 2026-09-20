#!/usr/bin/env ruby
require "pastel"
pastel = Pastel.new

# Definición de un Struct llamado Point
Point = Struct.new(:x, :y)

# Pedir al usuario las coordenadas X e Y de dos puntos en el espacio
points = []

puts pastel.green "==> Introducir las coordenas (x,y)"
2.times do
  puts "Punto #{_1}:"
  point = Point.new(0.0, 0.0)

  print "  punto[#{_1}].x? "; point.x = gets.to_f
  print "  punto[#{_1}].y? "; point.y = gets.to_f
  points << point
end

# Salida por pantalla
p0 = points[0]
p1 = points[1]
puts pastel.green "==> Salida por pantalla:"
puts "  Punto 0 (#{p0.x}, #{p0.y})"
puts "  Punto 1 (#{p1.x}, #{p1.y})"

# Mostrar por pantalla la distancia en línea recta entre esos dos puntos
distance = Math.sqrt((p1.x - p0.x)**2 + (p1.y - p0.y)**2)

puts pastel.green("==> La distancia es: ") + distance.to_s

# Mostrar por pantalla las coordenadas del punto medio exacto de ambos.
midpoint = Point.new(0, 0)
midpoint.x = (p0.x + p1.x) / 2.0
midpoint.y = (p0.y + p1.y) / 2.0
puts pastel.green("==> El punto medio es: ") + "(#{midpoint.x}, #{midpoint.y})"
