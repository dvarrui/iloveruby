#!/usr/bin/env ruby

puts "Escribe un número: "
number = gets.to_i

fib_2 = 0
fib_1 = 1

(0..number).each do |n|
  if n.zero?
    puts "fib(0) = 0"
  elsif n == 1
    puts "fib(1) = 1"
  else
    fib = fib_2 + fib_1
    puts "fib(#{n}) = #{fib}"
    fib_2 = fib_1
    fib_1 = fib
  end
end
