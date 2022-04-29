#!/usr/bin/env ruby

list = [ 3, 5, 0, 'hello', [], nil ]

puts "===> for"
for i in list
  puts "El elemento #{i} es de tipo #{i.class}"
end

puts "===> each"
list.each do |i|
  puts "El elemento #{i} es de tipo #{i.class}"
end
