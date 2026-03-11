#!/usr/bin/env ruby

require 'colorize'

def succ_a(x)
  n = x.to_r
  (n * n) - (3 * n)
end

def succ_b(x)
  n = x.to_r
  n - (24 / n)
end

def succ_c(x)
  n = x
  (-1)**n
end

numbers = [1, 2, 3, 10]

# numbers.each { |n| puts "Sucesión a#{n} = #{succ_a(n)}" }
# numbers.each { |n| puts "Sucesión b#{n} = #{succ_b(n)}" }
numbers.each { |n| puts "Sucesión c#{n} = #{succ_c(n)}" }
