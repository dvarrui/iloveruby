#!/usr/bin/env ruby
require "pastel"
pastel = Pastel.new

# Definición de un Struct llamado Point
Point = Struct.new(:x, :y) do
  # Calcular ls distancia entre puntos
  def distance_to(other)
    Math.hypot(other.x - x, other.y - y)
  end

  def midpoint_to(other)
    mid = Point.new(0, 0)
    mid.x = (x + other.x) / 2.0
    mid.y = (y + other.y) / 2.0
    return mid
  end

  def to_s
    "(#{x}, #{y})"
  end
end

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
puts "  Punto 0 #{p0}"
puts "  Punto 1 #{p1}"

# Mostrar por pantalla la distancia en línea recta entre esos dos puntos
print pastel.green("==> La distancia es: ")
puts p0.distance_to(p1)

# Mostrar por pantalla las coordenadas del punto medio exacto de ambos.
print pastel.green("==> El punto medio es: ")
puts p0.midpoint_to(p1)
