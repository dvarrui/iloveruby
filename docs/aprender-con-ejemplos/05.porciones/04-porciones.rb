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

# Fase 3: Mostrar por pantalla los números en orden inverso.
puts "==> [Fase 3] Mostrar por pantalla los números en orden inverso:"
puts numbers.reverse.to_s

# Fase 4: 
#   Partir la lista en dos mitades 
#   (Si el número de elementos es impar, una parte será mayor que otra).
#   Mostrar las dos mitades por pantalla
half_size = numbers.length / 2
half_numbers1 = numbers.take(half_size)
half_numbers2 = numbers - half_numbers1

puts "==> [Fase 4] Dividir el listado en dos mitades:"
puts "Mitad 1 : #{half_numbers1}"
puts "Mitad 2 : #{half_numbers2}"

