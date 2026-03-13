#!/usr/bin/env ruby
require_relative "lib/si-entonces-sino-v1"

# Estructura si-entonces-sino sin ;
number = 10

si { number >= 18 }
  entonces { puts "Adulto" }
  sino { puts "Menor" }

# Estructura si-entonces-sino con ;
number = 52

si { number >= 18 }
entonces {
  puts "Adulto"
}; sino {
  puts "Menor"
}
