#!/usr/bin/env ruby
$VERBOSE=nil

data1 = :data

ractor1 = Ractor.new data1 do |input|
  puts "[ractor 1] #{input.class} | #{input} | id:#{input.object_id}"
end

data2 = [1,2,3]

ractor2 = Ractor.new data2 do |input|
  puts "[ractor 2] #{input.class} | #{input} | id:#{input.object_id}"
end

puts "[  main  ] #{data1.class} | #{data1} | id:#{data1.object_id}"
puts "[  main  ] #{data2.class} | #{data2} | id:#{data2.object_id}"

ractor1.take
ractor2.take
