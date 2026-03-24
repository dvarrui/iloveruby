#!/usr/bin/env ruby

# F1: Pedir 10 números al usuario y almacenarlos en una lista (Array)
numbers = []

puts "Escribir 10 números:"
10.times do
  print("- numbers[#{_1}]? ")
  numbers[_1] = gets.to_i
end

# F2: Motrar los números por pantalla
puts "\nTenemos los siguientes valores:"

# F3: Mostrar el texto "NEGATIVO" cuando el número sea negativo
numbers.each do
  info = _1.negative? ? "(NEGATIVO)" : ""
  puts "- number #{_1} #{info}"
end