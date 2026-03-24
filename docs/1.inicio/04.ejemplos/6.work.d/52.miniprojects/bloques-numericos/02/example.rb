#!/usr/bin/env ruby

require_relative 'panel'
require_relative 'pretty'

puts "[PASO 2] Rellenar la sección de 3x3 con valores del 1 al 9."

panel = Panel.new
panel.random_fill

Pretty.print panel
