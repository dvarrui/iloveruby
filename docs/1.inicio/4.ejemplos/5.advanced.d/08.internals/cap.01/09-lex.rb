#!/usr/bin/env ruby
require_relative "show"

code = <<STR
array = []
10.times do |n|
  array << n if n < 5
end
p array
STR
puts code

show_lex code