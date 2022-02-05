#!/usr/bin/env ruby

require_relative 'lib/utils'

# Estructura secuencial
# Tipos. Range, Array, Hash

# Range
now_cames(:Range, <<-TEXT
interval = -2..2

puts interval.class
puts interval
puts interval.to_a
TEXT
)

interval = -2..2

puts interval.class
puts interval
puts interval.to_a

# Array
now_cames(:Array, <<-TEXT
jedis = ['Quigon', 'Obi-wan', 'Yoda', 'Luke']

puts jedis.class
for name in jedis do
  puts " * \#{name}"
end

puts jedis.sort.join(', ')
TEXT
)

jedis = ['Quigon', 'Obi-wan', 'Yoda', 'Luke']

puts jedis.class
for name in jedis do
  puts " - #{name}"
end

puts jedis.sort.join(', ')

# Hash
now_cames(:Hash, <<-TEXT
data = { name: 'Obi-wan', rol: 'Jedi' }

puts data.class
puts data
puts data[:name]
TEXT
)

data = { name: 'Obi-wan', rol: 'Jedi' }

puts data.class
puts data
puts data[:name]
