#!/usr/bin/env ruby

numbers = [ 4, -2, 0, 1, -5, -1, 2, -7 ]

def group1_with(elements)
  puts "[INFO] Using group1"
  zeros = elements.select { _1.zero? }
  positives = elements.select { _1.positive? }
  negatives = elements.select { _1.negative? }
  return negatives, zeros, positives
end

def group2_with(elements)
  puts "[INFO] Using group2"
  data = { zeros: [], positives: [], negatives: [] }
  for element in elements
    if element == 0
      data[:zeros] << element
    elsif element > 0
      data[:positives] << element
    else
      data[:negatives] << element
    end
  end

  return data[:negatives], data[:zeros], data[:positives]
end

def group3_with(elements)
  puts "[INFO] Using group4"
  data = { -1 => [], 0 => [], 1 => [] }
  elements.each { data[_1 <=> 0] << _1 }
  return data[-1], data[0], data[1]
end

n, z, p = group3_with numbers

puts " Numbers   : #{numbers}"
puts " Negatives : #{n}"
puts " Zeros     : #{z}"
puts " Positives : #{p}"
