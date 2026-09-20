#!/usr/bin/ruby

require 'test/unit'
require_relative '../lib/filo'

class FiloTest < Test::Unit::TestCase

  def test_new_filo_is_empty
    filo = Filo.new
    assert_equal true, filo.empty?
  end

end
