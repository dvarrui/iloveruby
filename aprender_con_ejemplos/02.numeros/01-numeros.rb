#!/usr/bin/env ruby

# Introducir el valor numérico
print("Número? "); number = gets.to_i

# Comprobamos que esté entre 10 y 20
if number < 10 || number > 20
  puts "Usage: #{$0} NUMBER"
  puts "  El número NUMBER debe estar entre 10 y 20"
  exit 1
end
