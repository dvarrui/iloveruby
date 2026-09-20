#!/usr/bin/env ruby
require "power_assert"
require "power_assert/colorize"
require 'test/unit'

class MyTest < Test::Unit::TestCase
  def test_something
    assert { 3.times.to_a.include?(3) }
  end
end
