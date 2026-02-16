#!/usr/bin/env ruby
if not ARGV.first
  puts "Usage: #{$0} NAME"
  exit 1
end

name = ARGV.first
puts "Hello #{name.capitalize}!"
