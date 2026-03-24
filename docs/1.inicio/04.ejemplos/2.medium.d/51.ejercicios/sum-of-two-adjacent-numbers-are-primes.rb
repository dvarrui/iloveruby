#!/usr/bin/env ruby

def prime?(n)
  max = (n**0.5).to_i + 1
  (2..max).each do |i|
    return false if n % i == 0
  end
  true
end

puts "The first 20 pairs of adjacent numbers whose sum is prime:"
counter = 0
number = 0

while (counter < 20) do
  number += 1
  sum = number * 2 +1

  if prime?(sum)
    counter += 1
    puts("[%2d] %2d + %2d = %2d" % [counter, number, (number+1), sum])
  end
end
