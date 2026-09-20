#!/usr/bin/env ruby
if ARGV.size < 2
  puts "Usage: #{$0} NAME NUMBER"
  exit 1
end

name = ARGV[0]
number = ARGV[1].to_i

number.times { puts "Hello #{name.capitalize}!" }
