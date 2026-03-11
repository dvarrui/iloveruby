#!/usr/bin/env ruby

source = <<~RUBY
  puts d
  a = 3
  b = 4
  c = a + b
  puts c
RUBY

d = "hola"

source.split("\n").each_with_index do |line, index|
  puts "#{index}: #{line}"
  begin
    eval(line, binding)
  rescue NameError => e
    puts "[NameError] #{e}"
  end
end
