#!/usr/bin/env ruby

# Pedir 10 números al usuario y almacenarlos en una lista (Array)
numbers = []

puts "Escribir 10 números:"
10.times do
  print("- numbers[#{_1}]? ")
  numbers[_1] = gets.to_i
end

# Motrar los números por pantalla
puts "\nTenemos los siguientes valores:"

numbers.each do
  # Mostrar el texto "NEGATIVO" cuando el número sea negativo
  info = _1.negative? ? "(NEGATIVO)" : ""
  puts "- number #{_1} #{info}"
end