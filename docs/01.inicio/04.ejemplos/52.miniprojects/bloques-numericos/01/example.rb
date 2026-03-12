#!/usr/bin/env ruby

require_relative 'panel'
require_relative 'pretty'

puts "[PASO 1] Crear el panel de 4x4."

panel = Panel.new
Pretty.print panel
