#!/usr/bin/env ruby

# Creating blocks/lambda

p1 = Proc.new { |x| x + 1 }
p2 = proc     { |x| x + 1 }
p3 = lambda   { |x| x + 1 }
p4 = -> x { x + 1 }

puts p1.call(0)
puts p2.call(1)
puts p3.call(2)
puts p4.call(3)

# Invoke block
puts p4.call(4)
puts p4[5]
puts p4 === 6
puts p4.(7)

puts p1 == p1
puts p1 == p4
puts p1.object_id
puts p4.object_id
