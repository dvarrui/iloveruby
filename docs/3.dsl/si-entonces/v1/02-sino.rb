#!/usr/bin/env ruby
require_relative "lib/si-entonces-sino-v1"

# Estructura si-entonces-sino sin ;
edad = 10
nombre = "Pitufo"

si (edad >= 18 )
  entonces { puts "#{nombre} es adulto" }
  sino { puts "#{nombre} es menor" }

# Estructura si-entonces-sino con ;
edad = 52
nombre = "Obiwan"

si (edad >= 18)
entonces {
  puts "#{nombre} es adulto"
}; sino {
  puts "#{nombre} es menor"
}
