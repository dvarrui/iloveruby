#!/usr/bin/env ruby

puts "PID:#{Process.pid}"
puts "Push Ctrl-C" 
trap(:INT) { puts 'This is the first signal handler' }

old_handler = trap(:INT) {
  old_handler.call
  puts 'This is the second handler'
  exit
}
sleep 15 # so that we have time to send it a signal
