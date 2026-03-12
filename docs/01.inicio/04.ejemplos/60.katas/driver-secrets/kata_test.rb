#!/usr/bin/env ruby

require "test/unit"
require_relative "kata"
require_relative "driver"

class KataTest < Test::Unit::TestCase
  def test_2_drivers
    drivers = [
      Driver.new([1, 2, 1], "A1"),
      Driver.new([1, 3, 1], "B2")
    ]
    kata = Kata.new(drivers)
    assert_equal 1, kata.result
  end

  def test_3_drivers_no_result
    drivers = [
      Driver.new([1, 2, 3], "A1"),
      Driver.new([4, 5, 6], "B2"),
      Driver.new([7, 8, 9], "C3")
    ]
    kata = Kata.new(drivers)
    assert_equal "never", kata.result
  end

  def test_3_drivers_result
    drivers = [
      Driver.new([1, 2, 8], "A1"),
      Driver.new([1, 3, 7], "B2"),
      Driver.new([2, 3, 4, 5], "C3")
    ]
    kata = Kata.new(drivers)
    assert_equal 4, kata.result
  end
end