#!/usr/bin/env ruby

require_relative 'lib/my_integer'

n1 = MyInteger.new(1)
n2 = MyInteger.new(2)
n3 = MyInteger.new(3)
n4 = MyInteger.new(4)

result = n1.pipe(n2).pipe(n3)
puts result.to_s

result = n1.pipe(n2).pipe(n3).pipe(n4)
puts result.to_s
