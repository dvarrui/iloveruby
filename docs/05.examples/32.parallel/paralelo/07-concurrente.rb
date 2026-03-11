#!/usr/bin/env ruby

require_relative '07-concurrente-lib'

inputs = [ 2, 4, 6, 8].shuffle
action = lambda { |id,delay| do_something(id,delay)}

begin_work inputs
inputs.parallelize action
end_work
