#!/usr/bin/env ruby

require_relative 'panel'
require_relative 'pretty'

puts "[PASO 3] Calcular las sumas de filas, columnas y diagonal."

panel = Panel.new
panel.random_fill
panel.calculate_sum

Pretty.print panel
