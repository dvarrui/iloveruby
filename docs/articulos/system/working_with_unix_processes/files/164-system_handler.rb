#!/usr/bin/env ruby

puts "PID:#{Process.pid}"
puts "Push Ctrl-C"

system_handler = trap(:INT) {
  puts 'about to exit!'
  system_handler.call
}
sleep 5 #
