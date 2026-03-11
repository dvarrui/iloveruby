#!/usr/bin/env ruby

require "colorize"
require "debug"

module StepByStep
  def self.call(source)
    scope = binding
    source.split("\n").each_with_index do |line, index|
      system("clear")
      show_code(source, index)
      begin
        puts "\n[output]".colorize(:white)
        scope = eval("#{line}; binding", scope)
      rescue NameError => e
        puts "[NameError] #{e}"
      end
      print "\n(enter)"
      gets
    end
  end

  def self.show_code(source, current)
    puts "[source code]".colorize(:white)
    lines = source.split("\n")
    lines.each_with_index do |line, index|
      arrow = " "
      color = :white
      if index == current
        arrow = "\u{279C}"
        color = :light_white
      end
      str = "#{index}: #{arrow} #{line}"
      puts str.colorize(color)
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
