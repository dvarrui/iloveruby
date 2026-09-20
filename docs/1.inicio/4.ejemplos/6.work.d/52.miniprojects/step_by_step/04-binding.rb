#!/usr/bin/env ruby

require "colorize"
require "debug"

source = <<~RUBY
  puts d
  a = 3
  b = 4
  c = a + b
  puts c
RUBY

d = "hola"

scope = binding
source.split("\n").each_with_index do |line, index|
  puts "#{index}: #{line}".colorize(:white)
  begin
    scope = eval("#{line}; binding", scope)
  rescue NameError => e
    puts "[NameError] #{e}"
  end
end
