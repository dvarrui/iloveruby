#!/usr/bin/env ruby
# Requiere Ruby 3.4.0 o superior

# A. Introducir el valor numérico por argumentos
number = ARGV[0].to_i

# Comprobamos que esté entre 10 y 20
if number < 10 or number > 20
  puts "Usage: #{$0} NUMBER"
  puts "  El número NUMBER debe estar entre 10 y 20"
  exit 1
end

# B. Mostrar por pantalla todos los números enteros entre el 1 y el N.
puts "Números enteros entre 1 y #{number}"

(1..number).each { print "#{it} " }

# C. Mostrar por pantalla todos los números enteros entre el 30 y el N, en orden inverso.
puts "\n\n"
puts "Números enteros entre 30 y #{number}"

(30..number).step(-1).each { print "#{it} " }

puts
