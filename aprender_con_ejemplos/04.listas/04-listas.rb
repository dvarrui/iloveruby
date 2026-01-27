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
# Calcular el total de ocurrencias de cada número
occurrences = numbers.group_by { _1 }

numbers.each do
  # Mostrar el texto "NEGATIVO" cuando el número sea negativo
  info1 = _1.negative? ? "(NEGATIVO)" : ""
  # Mostrar el texto "REPETIDO" cuando las "ocurrencias" > 1
  info2 = (occurrences[_1].size > 1) ? "(REPETIDO)" : ""

  puts "- number #{_1} #{info1} #{info2}"
end