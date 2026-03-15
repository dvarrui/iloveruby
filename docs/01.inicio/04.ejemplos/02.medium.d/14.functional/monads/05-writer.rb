#!/usr/bin/env ruby

require_relative '05-writer-lib'

lam_sqrt = ->(number) { Math.sqrt(number) }
lam_add_one = ->(number) { number + 1 }
lam_half = ->(number) { number / 2.0 }

sqrt = Writer.unit( lam_sqrt, "Took square root")
add_one = Writer.unit( lam_add_one, "Added one")
half = Writer.unit( lam_half, "Divided by 2")

m1 = Writer.unit(5, "Initial value")
m2 = m1.bind(sqrt).bind(add_one).bind(half)

puts "The final value is #{m2.value}\n\n"
puts "This value was derived as follows:"
puts m2.log

