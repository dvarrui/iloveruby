#!/usr/bin/env ruby

class Writer
  attr_reader :value, :log

  def initialize(value, log = "New")
    @value = value
    if log.is_a? Array
      @log = log
    else
      msg = "|" + log.rjust(20) + " => " + @value.to_s
      @log = [ msg ]
    end
  end

  def self.unit(value, log)
    Writer.new(value, log)
  end

  def bind(proc, log)
    new_value = proc.call(@value)
    msg = "|" + log.rjust(20) + " => " + new_value.to_s
    new_log = @log << msg
    self.class.new(new_value, new_log.flatten)
  end

  def to_s
    "Writer value:#{@value}, log=#{log.to_s}"
  end
end

sqrt = ->(number) { Math.sqrt(number) }
add_one = ->(number) { number + 1 }
half = ->(number) { number / 2.0 }

m1 = Writer.unit(5, "Initial value")
m2 = m1.bind(sqrt, "Took square root").bind(add_one, "Added one").bind(half, "Divided by 2")
#  mw2 := mw1.bind(root).bind(addOne).bind(half)

puts "The Golden Ratio is #{m2.value}"
puts "\nThis was derived as follows:"
puts m2.log

