#!/usr/bin/env ruby
# http://rubylearning.com/blog/2013/04/04/ruby-matrix-the-forgotten-library/

require 'matrix'

a = Matrix.identity 2
puts "Matrix A = #{a}"

b = a * 2
puts "Matrix B = #{b}"

c = b * Matrix[ [0,1], [1,0] ]
puts "Matrix C = #{c}"
