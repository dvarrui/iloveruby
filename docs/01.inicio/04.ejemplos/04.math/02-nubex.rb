#!/usr/bin/env ruby

require_relative 'lib/02-nubex-lib'

a = Nubex.new(2, 3)
b = Nubex.new(3)

puts "#{a} = #{a.to_i}"
puts "#{b} = #{b.to_i}"

a.mul(b)
puts "#{a} = #{a.to_i}"

c = Nubex.new(3, -2)
a.mul(c)
puts "#{a} = #{a.to_i}"
