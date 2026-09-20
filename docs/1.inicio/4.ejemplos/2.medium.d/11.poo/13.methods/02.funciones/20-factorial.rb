#!/usr/bin/env ruby

def factorial(n)
  if n == 0
    1
  else
    n * factorial(n-1)
  end
end

number = 3

puts "factorial(#{number}) = #{factorial(number)}"
