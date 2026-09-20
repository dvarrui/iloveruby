#!/usr/bin/env ruby

require_relative '02-nubex-lib'

a = [ 90, 165, 244]

a.each do |i|
  puts "Número      #{i}"
  puts "Factorizado #{Nubex.factorize(i)}"
end
