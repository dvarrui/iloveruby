#!/usr/bin/env ruby

p1 = Proc.new { |x| x + 1 }
p2 = proc     { |x| x + 1 }
p3 = lambda   { |x| x + 1 }
p4 = -> x { x + 1 }


puts p1.call(0)
puts p2.call(1)
puts p3.call(2)
puts p4.call(3)
