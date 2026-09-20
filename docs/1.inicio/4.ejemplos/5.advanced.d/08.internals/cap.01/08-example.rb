#!/usr/bin/env ruby
require 'prism'
require 'pp'
require "debug"

code = <<STR
10.times do |n|
  puts n/4+6
end
STR
puts code

Prism.lex(code).value.each do |item|
  type = item[0].type.to_s
  value = item[0].value
  # binding.break
  loc = item[0].location
  location = "#{loc.start_line},#{loc.start_offset}(#{loc.length})"
  value = "<nl>" if value == "\n" 
  puts "#{type.ljust(15)} | #{value.ljust(15)} | #{location}"
end