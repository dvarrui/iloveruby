#!/usr/bin/env ruby

require_relative '08-secuencia-lib'

inputs = [ 1, 3, 5, 7].shuffle
@counter = 0

begin_work inputs
inputs.each_with_index { |input, index| do_something(index, input) }
end_work
