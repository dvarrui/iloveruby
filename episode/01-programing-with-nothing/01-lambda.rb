#!/usr/bin/env ruby
#

puts lambda { |x| x + 1 }.call(41)

puts lambda { |x, y|
  x + y
}.call(3, 4)

# currying

puts lambda { |x|
  lambda { |y|
    puts "[INFO] x=#{x}, y=#{y}"
    x + y
  }
}.call(3).call(4)
