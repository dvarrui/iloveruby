#!/usr/bin/env ruby

module Demo
  def run
    puts "run: #{@text}"
  end
end

include Demo
@text = "Hi!"
run
