#!/usr/bin/env ruby
# asigna valores iniciales
filename = 'points.txt'

# code
distances = []

File.foreach(filename) do |line|
  items = line.split
  x = items[0].to_i
  y = items[1].to_i
  distance = (x**2 + y**2)**0.5
  distances.append distance
end

# min_distance = 4.123105625617661
min_distance = distances.min
puts min_distance
