#!/usr/bin/ruby

Tuple = Struct.new(:_1, :_2)

t = Tuple.new("a", "b")
puts "t._1 #{t._1}"
puts "t._2 #{t._2}"

class Tuple
  def to_ary
    to_a
  end
end

a, b = t # => #<struct Tuple _1="a", _2="b">
puts "a #{a}"
puts "b #{b}"
