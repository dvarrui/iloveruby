#!/usr/bin/env ruby

Signal.trap(0, proc { puts "Terminating: #{$$}"; exit 0 })

loop do
  sleep(1)
  print "."
end
puts "the end"
