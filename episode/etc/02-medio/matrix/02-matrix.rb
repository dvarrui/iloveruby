#!/usr/bin/env ruby
# http://rubylearning.com/blog/2013/04/04/ruby-matrix-the-forgotten-library/

require_relative '02-matrix-lib'

a = MyMatrix.new :size => 2, :value => 0
puts "MyMatrix A #{a.to_s}"

b = MyMatrix.new :size => 2, :value => 3
puts "MyMatrix B #{b.to_s}"

c = MyMatrix.new :size => 2, :identity => true
puts "MyMatrix C #{c.to_s}"
