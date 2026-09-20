#!/usr/bin/env ruby

require_relative '04-concurrente-lib'

inputs = [ 2, 4, 6, 8].shuffle

begin_work inputs

tasks = []
inputs.each_with_index do |input, index|
  tasks << Thread.new{ do_something(index, input)}
end
tasks.each { |t| t.join }

end_work
