#!/usr/bin/env ruby

require 'colorize'

hoy    = "hoy".red
me     = "me".yellow
siento = "siento".light_yellow
muy    = "muy".light_green
feliz  = "feliz".light_blue

puts hoy + me + siento + muy + feliz
puts "\n\n"

iloveruby = "I love Ruby"
puts iloveruby.on_red
puts iloveruby.on_white.light_red
