#!/usr/bin/env ruby

require_relative '02-secuencia-lib'

inputs = [ 1, 3, 5, 7].shuffle

begin_work inputs
inputs.each_with_index { |input, index| do_something(index, input) }
end_work
