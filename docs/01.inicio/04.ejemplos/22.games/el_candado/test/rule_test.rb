#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../lib/combination'
require_relative '../lib/rule'

class RuleTest < Minitest::Test

  def test_rule_1
    combi = Combination.new(6, 8, 2)
    rule1 = Rule.new(combination: combi, included: 1, in_position: 1)

    combi0 = Combination.new(0, 0, 0)
    combi1 = Combination.new(0, 0, 2)
    combi2 = Combination.new(0, 0, 8)
    combi3 = Combination.new(6, 0, 8)

    assert_equal false, rule1.check(combi0)
    assert_equal true, rule1.check(combi1)
    assert_equal false, rule1.check(combi2)
    assert_equal false , rule1.check(combi3)
  end
end
