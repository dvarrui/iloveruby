#!/usr/bin/env ruby
require "debug"

class Parser
  def initialize(lines)
    @lines = lines
  end

  def sequence(code)
    @indexes = []
    instance_eval code
    puts @indexes == @indexes.sort
  end

  def find(value)
    @lines.each_with_index do |line, index|
      if line.include? value
        @indexes << index
        return
      end
    end
    @indexes << 999999
  end
end

lines = ["begin", "do something", "end"]
p = Parser.new(lines)
p.sequence %{
  find "begin"
  find "some"
  find "end"
}

p.sequence %{
  find "begin"
  find "end"
}

p.sequence %{
  find "some"
  find "end"
  find "begin"
}
