#!/usr/bin/ruby

puts "Programar en Ruby es divertido" =~ /Ruby/
puts "#{$`}<<#{$&}>>#{$'}"

text =  "Programar en Ruby es divertido"
filter = /Ruby/
result = filter.match(text)
puts "#{result.pre_match}<<#{result.match 0}>>#{result.post_match}"
