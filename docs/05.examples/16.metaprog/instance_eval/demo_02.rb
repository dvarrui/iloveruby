#!/usr/bin/env ruby
require "debug"

class Parser
  def initialize(lines)
    @lines = lines
  end

  def call(code)
    instance_eval code
  end

  def find(value)
    @lines.each_with_index do |line, index|
      puts index if line.include? value
    end
    puts "NODATA"
  end
end

lines = ["begin", "do something", "end"]
p = Parser.new(lines)
p.call %{
  puts self.class 
}
