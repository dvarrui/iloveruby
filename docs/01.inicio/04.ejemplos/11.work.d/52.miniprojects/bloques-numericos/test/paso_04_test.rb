#!/usr/bin/env ruby

require 'minitest/autorun'

class Paso04 < Minitest::Test

  def text_example
    ok = system("../04/example.rb")
    assert_equal true, ok
  end
end
