#!/usr/bin/env ruby

print "How much do you love me? (Integer) "
value = gets.to_i

## Estructura iterativa

puts "[ INFO ] while"
i = 0
while (i < value)
  print "(#{i}) Kiss "
  i += 1
end

puts "\n[ INFO ] iterator"
value.times { |i| print "(#{i}) Kiss " }

puts "\n"
