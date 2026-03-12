#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/combination'
require_relative '../lib/apply'

class ApplyTest < Minitest::Test

  def test_in_position
    combi = Combination.new(6, 8, 2)
    combi0 = Combination.new(0, 0, 0)
    combi1 = Combination.new(0, 0, 2)
    combi2 = Combination.new(0, 8, 2)
    combi3 = Combination.new(6, 8, 2)

    assert_equal 0, Apply.evaluate_in_position(combi, combi0)
    assert_equal 1, Apply.evaluate_in_position(combi, combi1)
    assert_equal 2, Apply.evaluate_in_position(combi, combi2)
    assert_equal 3, Apply.evaluate_in_position(combi, combi3)
  end

  def test_included
    combi = Combination.new(6, 8, 2)
    combi0 = Combination.new(0, 0, 0)
    combi1 = Combination.new(0, 2, 0)
    combi2 = Combination.new(8, 2, 0)
    combi3 = Combination.new(8, 2, 6)

    assert_equal 0, Apply.evaluate_included(combi, combi0)
    assert_equal 1, Apply.evaluate_included(combi, combi1)
    assert_equal 2, Apply.evaluate_included(combi, combi2)
    assert_equal 3, Apply.evaluate_included(combi, combi3)
  end

  def test_evaluate
    combi = Combination.new(6, 8, 2)

    combi2 = Combination.new(0, 0, 0)
    result = { included: 0, in_position: 0 }
    assert_equal result, Apply.evaluate(combi, combi2)

    combi2 = Combination.new(0, 2, 0)
    result = { included: 1, in_position: 0 }
    assert_equal result, Apply.evaluate(combi, combi2)

    combi2 = Combination.new(0, 8, 6)
    result = { included: 2, in_position: 1 }
    assert_equal result, Apply.evaluate(combi, combi2)

    combi2 = Combination.new(6, 8, 0)
    result = { included: 2, in_position: 2 }
    assert_equal result, Apply.evaluate(combi, combi2)

    combi2 = Combination.new(6, 8, 2)
    result = { included: 3, in_position: 3 }
    assert_equal result, Apply.evaluate(combi, combi2)

    combi2 = Combination.new(6, 2, 8)
    result = { included: 3, in_position: 1 }
    assert_equal result, Apply.evaluate(combi, combi2)
  end
end
