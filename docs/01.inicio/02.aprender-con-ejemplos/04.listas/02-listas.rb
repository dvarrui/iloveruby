#!/usr/bin/env ruby

# Pedir 10 números al usuario y almacenarlos en una lista (Array)
numbers = []

puts "Escribir 10 números:"

# Usar un bucle for
for index in 1..10
  print("- numbers[#{index}]? ")
  numbers[index] = gets.to_i
  index += 1
end
