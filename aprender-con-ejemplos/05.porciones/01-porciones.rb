#!/usr/bin/env ruby

# Fase 1:
#   Pedir números al usuario que se irán almacenandoen una lista.
#   Cuando se introduce un cero, se termina de pedir números.
numbers = []

puts "==> [Fase 1] Entrada de datos:"
loop do
  print("Número? "); number = gets.to_i
  break if number.zero?
  numbers << number
end

# DEBUG: Salida por pantalla
puts "--> [DEBUG] Salida de datos:"
puts "Valores: #{numbers}"