#!/usr/bin/env ruby 

print "How old are you? "
age = gets.to_i
adult = 18

if age < adult then
  puts "Minor"
else
  puts "Adult person"
end

puts "This is the end! (The doors)"
