#!/usr/bin/env ruby
require 'ruby2d'

set title: "Árbol Fractal Recursivo"
set width: 800
set height: 600
set background: '#1a1a1a'

def dibujar_rama(x1, y1, angulo, lon, grosor)
  return if lon < 5 # Condición de salida (caso base)

  # Calcular el punto final de la rama usando trigonometría
  # Convertimos el ángulo a radianes para las funciones Math.cos y Math.sin
  rad = angulo * Math::PI / 180
  x2 = x1 + Math.cos(rad) * lon
  y2 = y1 + Math.sin(rad) * lon

  # Dibujar la línea en pantalla
  Line.new(
    x1: x1, y1: y1,
    x2: x2, y2: y2,
    width: grosor,
    color: 'lime'
  )

  # Llamadas recursivas para las dos ramas hijas
  # Reducimos la longitud y el grosor en cada paso
  nueva_lon = lon * 0.75
  nuevo_grosor = [grosor * 0.7, 1].max

  # Rama derecha (+30 grados) y rama izquierda (-30 grados)
  dibujar_rama(x2, y2, angulo - 30, nueva_lon, nuevo_grosor)
  dibujar_rama(x2, y2, angulo + 30, nueva_lon, nuevo_grosor)
end

# Iniciamos el árbol desde la base (abajo al centro)
# Ángulo -90 es hacia arriba en el sistema de coordenadas de Ruby2D
dibujar_rama(400, 580, -90, 150, 8)

show

