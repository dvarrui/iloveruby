#!/usr/bin/env ruby

# Estructura secuencial

# Integer
a = 3
b = 3

puts a.class
puts a + b
puts a == b
puts a.object_id == b.object_id
puts

# Float
a = 3.2
b = 3.2

puts a.class
puts a / 0
puts 0.0 / 0.0
puts a / b
puts a == b
puts a.object_id == b.object_id
puts

# Rational

a = Rational(4) / 5 
b = '1/5'.to_r 

puts a.class
puts a 
puts a + b
puts a + 1
puts

# Complex
a = 2+1i
b = '1'.to_c

puts a.class
puts a + b
puts

# Matrix

require 'matrix'
a = Matrix[[1,0], [0,1]]
b = Matrix[[2,2], [3,3]]

puts a.class
puts a
puts a + b
puts a * 2
puts a * b
puts
