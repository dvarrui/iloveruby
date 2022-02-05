#!/usr/bin/env ruby

puts "Hola mundo"

1 + 2

a = 1
b = 2

if (c = a + b) == 3
  puts "[ Walrus 1] Walrus python in Ruby"
end

puts c


def walrus2()
  a = 3
  b = 3
  d = b * a
end

puts "[ Walrus 2] method = #{walrus2}" 

def walrus3()
  a = "david"
  b = 16
  c, d = a , b
end

e, f = walrus3
puts "[ Walrus 3] method =>  #{e}, #{f}"

# => Hola mundo
# => [ Walrus 1] Walrus python in Ruby
# => 3
# => [ Walrus 2] method = 9
# => [ Walrus 3] method =>  david, 16

