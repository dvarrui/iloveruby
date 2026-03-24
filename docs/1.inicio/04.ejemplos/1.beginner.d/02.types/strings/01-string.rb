#!/usr/bin/env ruby

sentence = "Sólo sé que no sé nada."
words = sentence.split 

puts "  sentences : #{sentence}" 
puts "       size : #{sentence.size}"
puts " words.size : #{words.size}"
puts "    reverse : #{words.reverse.join(" ")}"

