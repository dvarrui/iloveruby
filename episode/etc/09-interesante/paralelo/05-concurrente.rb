#!/usr/bin/env ruby

require_relative '05-concurrente-lib'

inputs = [ 2, 4, 6, 8].shuffle

begin_work inputs
parallelize inputs
end_work
