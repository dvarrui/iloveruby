#!/usr/bin/env ruby

def factorial(number)
  (2..number).inject(:*) || 1
end

max = 1000
t = []
(1..max).each do |i|
  t << Thread.new { factorial(i) }
end 

t.each { _1.join }
