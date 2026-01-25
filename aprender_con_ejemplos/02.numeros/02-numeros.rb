#!/usr/bin/env ruby

# Introducir el valor numérico por argumentos
number = ARGV[0].to_i

# Comprobamos que esté entre 10 y 20
if number < 10 or number > 20
  puts "Usage: #{$0} NUMBER"
  puts "  El número NUMBER debe estar entre 10 y 20"
  exit 1
end

# Mostrar por pantalla todos los números enteros entre el 1 y el N.
for i in 1..number
  puts i
end