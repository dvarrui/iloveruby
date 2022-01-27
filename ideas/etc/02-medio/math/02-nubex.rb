#!/usr/bin/env ruby

require_relative '02-nubex-lib'

a = Nubex.new(2, 3)
<<<<<<< HEAD
b = Nubex.new(3, 3)

puts "#{a} = #{a.value}"
puts "#{b} = #{b.value}"
=======
b = Nubex.new(3)

puts "#{a} = #{a.to_i}"
puts "#{b} = #{b.to_i}"

a.mul(b)
puts "#{a} = #{a.to_i}"

c = Nubex.new(3, -2)
a.mul(c)
puts "#{a} = #{a.to_i}"
>>>>>>> 916457ddfd39b25ae95503203287d0cbb8932b63
