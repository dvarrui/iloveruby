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

# Fase 2: Mostrar por pantalla los números en posición par de la lista
puts "==> [Fase 2] Salida de datos en posiciones pares:"
numbers.each_with_index do |value, index|
  puts "Posición[#{index}] = #{value}" if index.even?
end
