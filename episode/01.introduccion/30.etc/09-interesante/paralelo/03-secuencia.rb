#!/usr/bin/env ruby

require_relative '03-secuencia-lib'

inputs = [ 1, 3, 5, 7].shuffle
tasks = get_tasks_from inputs

begin_work inputs
tasks.each { |t| t.do_something }
end_work
