#!/usr/bin/env ruby

class MyIterator
  def initialize(times)
    @times = times
  end

  def each(block)
    i = 0
    while(i<@times)
      puts "[#{i}] Executing block"
      block.call
      i += 1
    end
  end
end

puts "SCRIPTNAME : #{$0}"
p = Proc.new{ puts "I love Ruby!" }
i = MyIterator.new(3)
i.each(p)
