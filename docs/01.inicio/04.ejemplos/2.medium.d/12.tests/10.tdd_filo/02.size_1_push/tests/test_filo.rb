#!/usr/bin/ruby

require 'test/unit'
require_relative '../lib/filo'

class FiloTest < Test::Unit::TestCase

  def test_new_filo_is_empty
    filo = Filo.new
    assert_equal true, filo.empty?
  end

  def test_add_1_element_then_size_equal_1
    filo = Filo.new
    filo.push(0)
    assert_equal 1, filo.size
  end
end
