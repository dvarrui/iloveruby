#!/usr/bin/env ruby

require_relative '06-concurrente-lib'

inputs = [ 2, 4, 6, 8].shuffle
action = lambda { |a,b| do_something(a,b)}

begin_work inputs
parallelize inputs, action
end_work
