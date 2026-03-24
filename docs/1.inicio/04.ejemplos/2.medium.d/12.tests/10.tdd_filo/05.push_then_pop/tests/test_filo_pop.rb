#!/usr/bin/ruby

require 'test/unit'
require_relative '../lib/filo'

class FiloPopTest < Test::Unit::TestCase

  def test_new_pop
    filo = Filo.new
    assert_equal nil, filo.pop
  end

  def test_push_1_element_and_pop_1_element
    filo = Filo.new
    filo.push(42)
    assert_equal 42, filo.pop
    assert_equal nil, filo.pop
  end

  def test_push_2_elements_and_pop_2_elements
    filo = Filo.new
    filo.push(42)
    filo.push(43)
    assert_equal 42, filo.pop
    assert_equal 43, filo.pop
    assert_equal nil, filo.pop
  end

  def test_filo_size_4_then_push_4_and_pop_4
    filo = Filo.new(4)
    (1..4).each { |item| filo.push(item) }
    assert_equal 1, filo.pop
    assert_equal 2, filo.pop
    assert_equal 3, filo.pop
    assert_equal 4, filo.pop
    assert_equal nil, filo.pop
  end

  def test_filo_size_5_then_push_6
    filo = Filo.new(5)
    (1..5).each { |item| filo.push(item) }
    assert_raise do
      filo.push(6)
    end
    assert_equal 5, filo.size
  end
end
