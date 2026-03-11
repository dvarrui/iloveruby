#!/usr/bin/env ruby

require "colorize"
require "tty-prompt"
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
prompt = TTY::Prompt.new
source.split("\n").each_with_index do |line, index|
  puts "#{index}: #{line}".colorize(:white)
  begin
    scope = eval("#{line}; binding", scope)
  rescue NameError => e
    puts "[NameError] #{e}"
  end
  prompt.yes?("Next line?".colorize(:white))
end
