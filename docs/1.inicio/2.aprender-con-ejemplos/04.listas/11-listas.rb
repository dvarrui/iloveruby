#!/usr/bin/env ruby

# F1: Pedir 10 números al usuario y almacenarlos en una lista (Array)
numbers = []

puts "Escribir 10 números:"
10.times do
  print("- numbers[#{it}]? ")
  numbers[it] = gets.to_i
end

# F2: Mostrar los números por pantalla
puts "\nTenemos los siguientes valores:"

# F4: Calcular el total de ocurrencias de cada número
occurrences = numbers.group_by { it }

numbers.each do
  # F3: Mostrar el texto "NEGATIVO" cuando el número sea negativo
  info_neg = it.negative? ? "(NEGATIVO)" : (" " * 11)
  # F4: Mostrar el texto "REPETIDO" cuando las "ocurrencias" > 1
  info_rep = (occurrences[it].size > 1) ? "(REPETIDO)" : ""

  puts "- number #{it} #{info_neg} #{info_rep}"
end