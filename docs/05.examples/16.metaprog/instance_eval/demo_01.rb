#!/usr/bin/env ruby

class Parser
  def initialize(lines)
    @lines = lines
  end

  def call
    @lines.each_with_index do |line, index|
      yield index, line
    end
  end
end

lines = ["begin", "do something", "end"]
p = Parser.new(lines)
p.call { puts "#{_1}: #{_2}" }
