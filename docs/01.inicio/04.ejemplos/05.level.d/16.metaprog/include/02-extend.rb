#!/usr/bin/env ruby

module Demo
  def run
    puts "run: #{@text}"
  end
end

extend Demo
@text = "Hi!"
run
