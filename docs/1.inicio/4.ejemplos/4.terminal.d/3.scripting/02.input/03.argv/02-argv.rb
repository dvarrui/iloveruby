#!/usr/bin/ruby

if ARGV.empty?
  puts "Usage: #{$0} NAME"
  exit 1
end 

puts "Hello #{ARGV.first.capitalize}!"
