#!/usr/bin/env ruby
require_relative "lib/si-entonces-sino-v3"

# Ejemplo 1: si-entonces
edad = 10
puts "\nEdad: #{edad}"

si(edad >= 18)
  .entonces { puts "Adulto" }
  .sino { puts "Menor" }

# Ejemplo 2: sino
edad = 55
puts "\nEdad: #{edad}"

si(edad >= 18)
  .entonces { puts "Adulto" }
  .sino { puts "Menor" }
