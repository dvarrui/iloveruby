#!/usr/bin/env ruby

require "colorize"
require "debug"

module StepByStep
  def self.call(source)
    scope = binding
    source.split("\n").each_with_index do |line, index|
      puts "#{index}: #{line}".colorize(:white)
      begin
        scope = eval("#{line}; binding", scope)
      rescue NameError => e
        puts "[NameError] #{e}"
      end
      print "(enter)"
      gets
    end
  end
end

source = <<~RUBY
  a = 3
  b = 4
  c = a + b
  puts c
RUBY

StepByStep.call(source)
