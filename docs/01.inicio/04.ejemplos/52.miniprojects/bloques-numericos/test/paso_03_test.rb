#!/usr/bin/env ruby

require 'minitest/autorun'

class Paso03 < Minitest::Test

  def text_example
    ok = system("../03/example.rb")
    assert_equal true, ok
  end
end
