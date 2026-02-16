#!/usr/bin/env ruby

print "How much do you love me? (Write a number) "
number = gets.to_i

(1..number).each { |i| puts "Kisses :-)" }

puts "I love Ruby!"
