#!/usr/bin/env ruby
require "debug"

class Parser
  def initialize(lines)
    @lines = lines
  end

  def sequence(&block)
    @indexes = []
    instance_eval(&block)
    puts @indexes == @indexes.sort
  end

  def find(value)
    @lines.each_with_index do |line, index|
      if line.include? value
        @indexes << index
        return
      end
    end
    @indexes << -1
  end
end

lines = ["begin", "do something", "end"]
p = Parser.new(lines)
p.sequence do
  find "begin"
  find "some"
  find "end"
end

p.sequence do
  find "begin"
  find "end"
end

p.sequence do
  find "some"
  find "end"
  find "begin"
end
