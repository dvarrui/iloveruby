#!/usr/bin/env ruby

require 'minitest/autorun'

class Paso02 < Minitest::Test

  def text_example
    ok = system("../02/example.rb")
    assert_equal true, ok
  end
end
