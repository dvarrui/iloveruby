#!/usr/bin/env ruby

list = [ 1, 2, 3 ]

puts "===> while"
index = 0
while( index < list.size)
  value = list[index]
  puts "El elemento #{value} es de tipo #{value.class}"
  index = index + 1
end

puts "===> for"
for i in list
  puts "El elemento #{i} es de tipo #{i.class}"
end

puts "===> each"
list.each do |i|
  puts "El elemento #{i} es de tipo #{i.class}"
end

