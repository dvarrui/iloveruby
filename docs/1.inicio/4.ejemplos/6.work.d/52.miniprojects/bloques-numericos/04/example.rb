#!/usr/bin/env ruby

require_relative 'panel'
require_relative 'pretty'

puts "[PASO 4.1] Inventarse un panel"

panel = Panel.new
panel.random_fill
panel.calculate_sum
Pretty.print panel

puts "[PASO 4.2] Dejar algunos huecos."

panel.put_holes
Pretty.print panel
