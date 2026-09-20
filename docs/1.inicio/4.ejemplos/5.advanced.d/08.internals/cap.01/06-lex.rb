#!/usr/bin/env ruby
require 'prism'
require 'pp'
code = <<STR
10.times do |n|
  puts n
end
STR
puts code

pp Prism.lex(code).value