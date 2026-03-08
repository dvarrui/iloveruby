#!/usr/bin/env ruby

# F1: Pedir 10 números al usuario y almacenarlos en una lista (Array)
numbers = []

puts "Escribir 10 números:"

# INFO: Usando un iterador
10.times do |index|
  print("- numbers[#{index}]? ")
  numbers[index] = gets.to_i
end
