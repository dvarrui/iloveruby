#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/combination'

class CombinationTest < Minitest::Test

  def setup
    @combi1 = Combination.new
    @combi2 = Combination.new(6, 1, 6)
    @combi3 = Combination.new(8, 9, 9)
  end

  def test_value
    assert_equal [0, 0, 0], @combi1.value
    assert_equal [6, 1, 6], @combi2.value
    assert_equal [8, 9, 9], @combi3.value
  end

  def test_to_s
    assert_equal '[0, 0, 0]', @combi1.to_s
    assert_equal '[6, 1, 6]', @combi2.to_s
    assert_equal '[8, 9, 9]', @combi3.to_s
  end

  def test_next
    assert_equal [0, 0, 1], @combi1.next.value
    assert_equal [6, 1, 7], @combi2.next.value
    assert_equal [9, 0, 0], @combi3.next.value
  end

  def test_digit2_next!
    combi = Combination.new(6, 9, 6)
    assert_equal [6, 9, 7], combi.next!.value
    assert_equal [6, 9, 8], combi.next!.value
    assert_equal [6, 9, 9], combi.next!.value
    assert_equal [7, 0, 0], combi.next!.value
    assert_equal [7, 0, 1], combi.next!.value
  end

  def test_digit3_next!
    combi = Combination.new(9, 9, 7)
    assert_equal [9, 9, 8], combi.next!.value
    assert_equal [9, 9, 9], combi.next!.value
    assert_equal [0, 0, 0], combi.next!.value
    assert_equal [0, 0, 1], combi.next!.value
  end
end
