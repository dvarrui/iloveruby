#!/usr/bin/env ruby

def factorial(n)
  return 1 if n <= 1
  
  n * factorial(n-1)
end

number = 3
puts "factorial(#{number}) = #{factorial(number)}"
