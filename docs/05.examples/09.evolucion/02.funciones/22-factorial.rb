#!/usr/bin/env ruby

def factorial(n)
  return 1 if n <= 1

  n * factorial(n-1)
end

numbers = [0, 1, 3, -1, 4]

numbers.each do |number|
  puts "factorial(#{number}) = #{factorial(number)}"
end
