#!/usr/bin/env ruby
require_relative "show"

code = <<STR
10.times do |n|
  puts n/4+6
end
STR
puts code

show_lex code