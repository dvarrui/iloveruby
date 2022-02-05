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
puts
TEXT
)

interval = -2..2
puts interval.class

puts interval
puts interval.to_a
puts


# Array
now_cames(:Array, <<-TEXT
jedis = ['Quigon', 'Obi-wan', 'Yoda', 'Luke']
puts jedis.class
for name in jedis do
  puts " - \#{name}"
end
for name in jedis.sort.reverse do
  puts " v \#{name}"
end
TEXT
)

jedis = ['Quigon', 'Obi-wan', 'Yoda', 'Luke']
puts jedis.class
for name in jedis do
  puts " - #{name}"
end
for name in jedis.sort.reverse do
  puts " v #{name}"
end

# Hash
now_cames(:Hash, <<-TEXT
data = { name: 'Obi-wan', rol: 'Jedi' }

puts data.class
puts data
puts
TEXT
)

data = { name: 'Obi-wan', rol: 'Jedi' }

puts data.class
puts data
puts
