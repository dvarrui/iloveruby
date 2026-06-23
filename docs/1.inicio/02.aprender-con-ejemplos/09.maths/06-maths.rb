#!/usr/bin/env ruby
require "debug"

# 1. Pedir varios números al usuario y almacenar en una lista
puts "Vete escribiendo números, y <vacío> cuando termines"
numbers = []

loop {
  number = gets.to_i
  break if number.zero?
  numbers << number
}

# 2. Recorrer todas las combinaciones y calcular el MCM y el MCD de cada una
numbers.each_with_index do |number, index|
  n1 = number
  sublist = numbers[index + 1, numbers.size]
  sublist.each do |n2|
    print "n1=#{n1},".rjust(8)
    print "n2=#{n2} =>".rjust(10)
    print "mcd=#{n1.gcd(n2)},".rjust(8)
    puts  "mcm=#{n1.lcm(n2)}".rjust(8)
  end
end
