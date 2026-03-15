#!/usr/bin/env ruby
require 'ruby2d'

# Configuración de la ventana
set title: "Fractal de Mandelbrot con Ruby2D"
set width: 600
set height: 600

# Parámetros del fractal
# MAX_ITER = 30
MAX_ITER = 2
WIDTH = get :width
HEIGHT = get :height

# Función para mapear un rango a otro
def map_value(val, low1, high1, low2, high2)
  low2 + (high2 - low2) * (val - low1) / (high1 - low1)
end

puts "Generando fractal... por favor espera."

(0...WIDTH).each do |x|
  (0...HEIGHT).each do |y|
    # Convertir coordenadas de pantalla a plano complejo
    zx = map_value(x, 0, WIDTH, -2.0, 1.0)
    zy = map_value(y, 0, HEIGHT, -1.5, 1.5)
    
    ca = zx
    cb = zy
    n = 0
    
    # Algoritmo de escape
    while n < MAX_ITER
      aa = zx * zx
      bb = zy * zy
      break if aa + bb > 4.0 # El punto "escapa" al infinito
      
      twoab = 2.0 * zx * zy
      zx = aa - bb + ca
      zy = twoab + cb
      n += 1
    end

    # Si n llegó al máximo, el punto está en el conjunto (color negro)
    # Si no, le damos un color basado en las iteraciones
    if n < MAX_ITER
      brightness = map_value(n, 0, MAX_ITER, 0, 1)
      Square.new(
        x: x, y: y, size: 1,
        color: [0, brightness, brightness, 1] # Un tono cian/azul
      )
    else
      Square.new(x: x, y: y, size: 1, color: 'black')
    end
  end
end

puts "¡Listo!"
show

