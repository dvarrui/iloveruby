#!/usr/bin/env ruby

# F1: Pedir 10 números al usuario y almacenarlos en una lista (Array)
numbers = []

puts "Escribir 10 números:"

# INFO: Usar un bucle while
index = 1
while(index <= 10)
  print("- numbers[#{index}]? ")
  numbers[index] = gets.to_i
  index += 1
end
