#!/usr/bin/env ruby 

print "How much do you love me? (Write a number) "
number = gets.to_i
laps = 0

while laps < number 
  puts "Kisses :-)"
  laps = laps + 1
  # laps += 1
end

puts "I love Ruby!"
