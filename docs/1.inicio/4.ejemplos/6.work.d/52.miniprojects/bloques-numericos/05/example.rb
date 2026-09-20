#!/usr/bin/env ruby

require_relative 'panel'
require_relative 'pretty'
require_relative 'pretty_color'

max = 20
max.times do |index|
  number = index + 1
  puts ""
  puts "-------------------------"
  puts "[#{number}] Solución y enunciado\n"
  panel = Panel.new
  panel.random_fill
  panel.calculate_sum
  PrettyColor.print panel

  puts ""
  panel.put_holes
  Pretty.print panel
end
