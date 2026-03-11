#!/usr/bin/env ruby

class TrueClass
  def if_then
    yield
    self
  end

  def else
    self
  end
end

class FalseClass
  def if_then
    self
  end

  def else
    yield
    self
  end
end

a = 3
( a % 2 == 0).if_then {
  puts "#{a} is even!"
}.else {
  puts "#{a} is odd!"
}
