#!/usr/bin/env ruby
require "test/unit"
require_relative "driver"

class DriverTest < Test::Unit::TestCase
  def setup
    @driver1 = Driver.new([1, 2, 1], "A1")
    @driver2 = Driver.new([1, 3, 1], "B2")
  end

  def test_new
    assert_equal ["A1"], @driver1.secrets
    assert_equal 1, @driver1.secrets.count
  end

  def test_share_secrets_with
    @driver1.share_secrets_with(@driver2)
    assert_equal ["A1", "B2"],  @driver1.secrets
    assert_equal 2, @driver1.secrets.count
  end

  def test_get_stop
    assert_equal 1, @driver1.get_stop(1)
    assert_equal 2, @driver1.get_stop(2)
    assert_equal 1, @driver1.get_stop(3)
  end
end