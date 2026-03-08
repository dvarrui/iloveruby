#!/usr/bin/env ruby

# F1: Pedir 10 números al usuario y almacenarlos en una lista (Array)
numbers = []

puts "Escribir 10 números:"

# INFO: iterador con parámetro numerado
10.times do
  print("- numbers[#{_1}]? ")
  numbers[_1] = gets.to_i
end
