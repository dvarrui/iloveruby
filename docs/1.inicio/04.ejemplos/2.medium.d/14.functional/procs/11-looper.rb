#!/usr/bin/env ruby
#

class Looper
  attr_reader :counter

  def initialize(&block)
    @block = block
    @counter = 0
  end

  def run
    @counter += 1
    @block.call(@counter)
  end

  def repeat(number)
    while(number > 0)
       self.run
       number -= 1
    end
  end

end

action1 = Looper.new { puts "I Love Ruby!" }
action1.repeat 3

action2  = Looper.new { |i| puts "Te doy #{i} besos!" }
action2.repeat 5
