#!/usr/bin/env ruby
# https://github.com/tomstuart/monads

class Optional
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def bind(block)
    return self if value.nil?

    new_value = block.call(value)
    Optional.unit(new_value)
  end

  def self.unit(value)
    Optional.new(value)
  end

  def to_s
    "[Optional] value=#{value}"
  end
end

upcase = lambda { _1.upcase }
yoda = Optional.unit("yoda").bind upcase
vader = Optional.unit(nil).bind upcase

puts yoda
puts vader
