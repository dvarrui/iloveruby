#!/usr/bin/env ruby
require 'ruby2d'

set title: "Triángulo de Sierpinski (Juego del Caos)", width: 600, height: 600, background: 'black'

# Vértices del triángulo principal
vertices = [
  {x: 300, y: 50},  # Superior
  {x: 50,  y: 550}, # Inferior Izquierda
  {x: 550, y: 550}  # Inferior Derecha
]

# Punto inicial (puede ser cualquiera)
current_x = 300
current_y = 300

# Dibujamos 20,000 puntos para que se vea denso
# 20000.times do
10000.times do
  # Elegir un vértice al azar
  v = vertices.sample
  
  # Calcular el punto medio entre el actual y el vértice elegido
  current_x = (current_x + v[:x]) / 2
  current_y = (current_y + v[:y]) / 2
  
  # Dibujar un "píxel" (cuadrado de tamaño 1)
  Square.new(x: current_x, y: current_y, size: 1, color: 'fuchsia')
end

show

