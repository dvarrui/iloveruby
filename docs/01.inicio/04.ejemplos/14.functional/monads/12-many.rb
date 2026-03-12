#!/usr/bin/env ruby
# https://github.com/tomstuart/monads

class Many
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def bind(block)
    return self if value.nil?

    new_value = []
    value.each { |item| new_value << block.call(item) }
    Many.unit(new_value)
  end

  def to_s
    "[Many] value=#{value}"
  end

  def self.unit(value)
    Many.new(value)
  end
end

names = Many.new(["Darth Vader", "Obiwan Kenobi"])

f1 = lambda { _1.upcase }
words = names.bind(f1)

puts names
puts words
