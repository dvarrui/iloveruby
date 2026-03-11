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

  def test_add_2_elements_then_size_equal_2
    filo = Filo.new
    filo.push(1)
    filo.push(2)
    assert_equal 2, filo.size
  end

  def test_push_1_and_pop_1_then_size_0
    filo = Filo.new
    filo.push(1)
    filo.pop
    assert_equal 0, filo.size
  end

  def test_push_2_and_pop_2_then_size_0
    filo = Filo.new
    filo.push(1)
    filo.pop
    filo.push(2)
    filo.pop
    assert_equal 0, filo.size
  end
end
