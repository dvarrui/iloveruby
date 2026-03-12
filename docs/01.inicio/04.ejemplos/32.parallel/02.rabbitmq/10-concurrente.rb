#!/usr/bin/env ruby

require_relative '10-concurrente-lib'

inputs = [ 1, 3, 5, 7].shuffle
action = lambda { |id,delay,mutex| do_something(id,delay,mutex)}
@counter = 0

begin_work inputs
inputs.parallelize action
end_work
