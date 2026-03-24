#!/usr/bin/env ruby
require_relative "lib/si-entonces-sino-v2"

# Ejemplo 1: si-entonces
edad = 10
nombre = "Pitufo"
puts "\nEdad: #{edad}"

si(edad >= 18)
  .entonces { puts "#{nombre} es adulto" }
  .sino { puts "#{nombre} es menor" }

# Ejemplo 2: sino
edad = 55
nombre = "Obiwan"
puts "\nEdad: #{edad}"

si(edad >= 18)
.entonces { puts "#{nombre} es adulto" }
.sino { puts "#{nombre} es menor" }
