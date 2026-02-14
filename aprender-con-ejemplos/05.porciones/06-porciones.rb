#!/usr/bin/env ruby
require "pastel"
pastel = Pastel.new

# Fase 1:
#   Pedir números al usuario que se irán almacenandoen una lista.
#   Cuando se introduce un cero, se termina de pedir números.
numbers = []

puts pastel.green "==> [Fase 1] Entrada de datos:"
loop do
  print("Número? "); number = gets.to_i
  break if number.zero?
  numbers << number
end

# Fase 2: Mostrar por pantalla los números en posición par de la lista
puts pastel.green "==> [Fase 2] Salida de datos en posiciones pares:"
numbers.each_with_index do |value, index|
  puts "Posición[#{index}] = #{value}" if index.even?
end

# Fase 3: Mostrar por pantalla los números en orden inverso.
puts pastel.green "==> [Fase 3] Mostrar por pantalla los números en orden inverso:"
puts numbers.reverse.to_s

# Fase 4: 
#   Partir la lista en dos mitades 
#   (Si el número de elementos es impar, una parte será mayor que otra).
#   Mostrar las dos mitades por pantalla
half_size = numbers.length / 2
half_numbers1 = numbers[0, half_size]
half_numbers2 = numbers[half_size, half_size + 1]

puts pastel.green "==> [Fase 4] Dividir el listado en dos mitades:"
puts "Mitad 1 : #{half_numbers1}"
puts "Mitad 2 : #{half_numbers2}"

# Fase 5:
#   Mostrar por pantalla todos los elementos de la primera mitad, 
#   exceptuando el primero y el último.
half_numbers1.delete_at(0)
half_numbers1.delete_at(-1)

puts pastel.green "==> [Fase 5] Mostrar mitad 1, sin los extremos:"
puts "Mitad 1 : #{half_numbers1}"