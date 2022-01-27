#!/usr/bin/env ruby

require_relative '01-square-lib'

1.upto(10).each do |i|
  puts format(" Number: %02d",i) +
       format(" Qrt: %02.4f", Math.sqrt(i)) +
       format(" Calculate: %02.4f", square_root(i))
end
