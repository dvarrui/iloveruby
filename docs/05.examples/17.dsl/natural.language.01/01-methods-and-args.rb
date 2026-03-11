#!/usr/bin/env ruby


def m1(value)
  puts "m2(value) => value = #{value}"
end


puts "\n"
puts "=> def m1(*) ..."
print "   m1 'a' 'b' 'c' => "
m1 'a' 'b' 'c'
print "   m1 'a','b','c' => "
m1 'a', 'b', 'c'

puts "\n"
puts "=> def m1(value) ..."
print "   m1 'a' 'b' 'c' => "
m1 'a' 'b' 'c'
print "   m1 'a','b','c'"
puts "   Argument error"

# m2 'a', 'b', 'c' # => Argument error

def m2(*args)
  puts "m2(*args) => args = #{args}"
end

puts "\n"
puts "=> def m3(*args)"
print "   m3 'a' 'b' 'c' =>" 
m3 'a' 'b' 'c' 
print "   m3 'a', 'b', 'c' => "
m3 'a', 'b', 'c'


def m1(*)
  puts "m1(*) => "
end
