#!/usr/bin/env ruby

numbers = [ 4, -2, 0, 1, -4, -1, 2, 7, -7 ]

negatives = numbers.select { |n| n < 0 }
puts negatives.sort.to_s
