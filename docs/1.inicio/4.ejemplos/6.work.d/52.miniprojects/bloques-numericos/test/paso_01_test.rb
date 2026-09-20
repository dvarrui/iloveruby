#!/usr/bin/env ruby

require 'minitest/autorun'
require_relative '../01/panel'

class Paso01 < Minitest::Test

  def setup
    @panel1 = Panel.new
  end

  def test_panel_new_4
    panel = @panel1
    row = Array.new(4, 0)

    assert_equal row, panel.data[0]
    assert_equal row, panel.data[1]
    assert_equal row, panel.data[2]
    assert_equal row, panel.data[3]
  end

  def test_panel_to_s
    panel = @panel1
    text = "[[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]]"
    assert_equal text, panel.to_s
  end

  def text_example
    ok = system("../01/example.rb")
    assert_equal true, ok
  end
end
