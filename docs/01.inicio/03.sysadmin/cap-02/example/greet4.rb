#!/usr/bin/env ruby
if ARGV.size < 2
  puts "Usage: #{$0} NAME NUMBER"
  exit 1
end

name = ARGV[0]        # First  argument
number = ARGV[1].to_i # Second argument convertod into Integer
puts "Hello #{name.capitalize * number}!"
