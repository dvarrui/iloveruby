#!/usr/bin/env ruby

# Estructura secuencial

# Range
interval = -2..2

puts interval.class
puts interval
puts interval.to_a
puts

# Array
jedis = ['Quigon', 'Obi-wan', 'Yoda', 'Luke']
puts jedis.class
for name in jedis do
  puts " * #{name}"
end
puts

# Hash
data = { name: 'Obi-wan', rol: 'Jedi' }

puts data.class
puts data
puts 

