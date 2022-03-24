#!/usr/bin/env ruby

require_relative 'lib/utils'

# Estructura secuencial
# Tipos: Integer, Float, Rational, Complex, Matrix

# Integer
now_cames(:integer, <<-TEXT
a = 3
b = 3

puts a.class
puts a + b
puts a == b
puts a.object_id == b.object_id
TEXT
)

a = 3
b = 3

puts a.class
puts a + b
puts a == b
puts a.object_id == b.object_id

# Float
now_cames(:float, <<-TEXT
a = 3.2
b = 3.2

puts a.class
puts a / 0
puts 0.0 / 0.0
puts a / b
puts a == b
puts a.object_id == b.object_id
TEXT
)

a = 3.2
b = 3.2

puts a.class
puts a / 0
puts 0.0 / 0.0
puts a / b
puts a == b
puts a.object_id == b.object_id

# Rational
now_cames(:rational, <<-TEXT
a = Rational(4) / 5
b = '1/5'.to_r

puts a.class
puts a
puts a + b
puts a + 1
TEXT
)

a = Rational(4) / 5
b = '1/5'.to_r

puts a.class
puts a
puts a + b
puts a + 1

# Complex
now_cames(:complex, <<-TEXT
a = 2+1i
b = '1'.to_c
c = (-1)**(0.5)

puts a.class
puts a + b
puts c
TEXT
)

a = 2+1i
b = '1'.to_c
c = (-1)**(0.5)

puts a.class
puts a + b
puts c

# Matrix
now_cames(:matrix, <<-TEXT
require 'matrix'
a = Matrix[[1,0], [0,1]]
b = Matrix[[2,2], [3,3]]

puts a.class
puts a
puts a + b
puts a * 2
puts a * b
TEXT
)

require 'matrix'
a = Matrix[[1,0], [0,1]]
b = Matrix[[2,2], [3,3]]

puts a.class
puts a
puts a + b
puts a * 2
puts a * b
