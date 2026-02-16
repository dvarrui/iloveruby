#!/usr/bin/env ruby
if ARGV.empty?
  puts "Usage: #{$0} NAME1 NAME2 NAME3 ..."
  exit 1
end

for name in ARGV do
  puts "Hello #{name.capitalize}!"
end
