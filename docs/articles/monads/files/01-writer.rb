#!/usr/bin/env ruby

class Writer
  attr_reader :value

  def initialize(value)
    @value = value
    puts "new ==> #{self.to_s}"
  end

  def unit
    self.class.new(@value)
  end

  def bind(proc)
    new_value = proc.call(@value)
    self.class.new(new_value)
  end

  def to_s
    "Writer monad (value=#{@value})"
  end
end

m1 = Writer.new(5)

sqrt = ->(number) { Math.sqrt(number) }
add_one = ->(number) { number + 1 }
half = ->(number) { number / 2.0 }

m2 = m1.bind(sqrt).bind(add_one).bind(half)
