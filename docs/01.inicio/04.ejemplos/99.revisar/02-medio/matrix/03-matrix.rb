#!/usr/bin/env ruby
# http://rubylearning.com/blog/2013/04/04/ruby-matrix-the-forgotten-library/

require_relative '03-matrix-lib'

a = MyMatrix.new :size => 2, :identity => true
puts "MyMatrix A #{a.to_s}"
puts "  A(0,0) = #{a.get(0,0)}"
puts "  A(1,0) = #{a.get(1,0)}"
puts "  A(0,1) = #{a.get(0,1)}"
puts "  A(1,1) = #{a.get(1,1)}"

b = MyMatrix.new :size => 2, :value => 3
puts "MyMatrix B #{b.to_s}"
b.set(1,1,0)
puts "MyMatrix B #{b.to_s}"

c = a.sum b
puts "MyMatrix C #{c.to_s}"
