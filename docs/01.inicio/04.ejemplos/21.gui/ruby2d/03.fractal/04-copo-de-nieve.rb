#!/usr/bin/env ruby
require 'ruby2d'

set title: "Copo de Nieve de Koch", width: 800, height: 600

def dibujar_koch(x1, y1, x2, y2, iteracion)
  if iteracion == 0
    Line.new(x1: x1, y1: y1, x2: x2, y2: y2, width: 1, color: 'aqua')
  else
    # Calcular puntos intermedios
    dx = x2 - x1
    dy = y2 - y1

    # Dividir el segmento en 3 partes
    px1 = x1 + dx / 3.0
    py1 = y1 + dy / 3.0

    px3 = x1 + 2 * dx / 3.0
    py3 = y1 + 2 * dy / 3.0

    # Calcular el vértice del "pico" (triángulo equilátero)
    # Usamos rotación de 60 grados
    h = Math.sqrt(3) / 6.0
    px2 = (x1 + x2) / 2.0 - h * dy
    py2 = (y1 + y2) / 2.0 + h * dx

    # Llamadas recursivas para los 4 nuevos segmentos
    dibujar_koch(x1, y1, px1, py1, iteracion - 1)
    dibujar_koch(px1, py1, px2, py2, iteracion - 1)
    dibujar_koch(px2, py2, px3, py3, iteracion - 1)
    dibujar_koch(px3, py3, x2, y2, iteracion - 1)
  end
end

# Dibujar los 3 lados para formar el "copo" completo
iteraciones = 4
dibujar_koch(200, 450, 600, 450, iteraciones) # Base
dibujar_koch(600, 450, 400, 100, iteraciones) # Lado derecho
dibujar_koch(400, 100, 200, 450, iteraciones) # Lado izquierdo

show

