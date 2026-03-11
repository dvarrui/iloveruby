#!/usr/bin/env ruby

require 'test/unit'
require_relative '01-split_text_with_dict'

class SplitTextWithDictTest < Test::Unit::TestCase

  def test_1_one_solution
    text = "abc"
    dict = [ "a", "b", "c" ]
    assert_equal [ "a", "b", "c" ], split_text_with_dict(text, dict)[0]
  end

  def test_2_no_solution
    text = "abd"
    dict = [ "a", "b", "c" ]
    assert_equal nil, split_text_with_dict(text, dict)[0]
  end

  def test_3_one_solution
    text = "abc"
    dict = [ "a", "bc", "c" ]
    assert_equal [ "a", "bc" ], split_text_with_dict(text, dict)[0]
  end
  
  def test_4_two_solutions
    text = "abc"
    dict = [ "a", "ab", "bc", "c" ]
    assert_equal [ "a", "bc" ], split_text_with_dict(text, dict)[0]
    assert_equal [ "ab", "c" ], split_text_with_dict(text, dict)[1]
  end
end
