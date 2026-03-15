#!/usr/bin/env ruby
require 'test/unit'
require_relative 'first_or_last'

class TestFirstOrLast < Test::Unit::TestCase
  def setup
    @examples = [
      { text: "Hola Caracola!", first: "o", last: "a" },
      { text: "HOlA CaracolA!", first: "a", last: "o" },
      { text: "Pienso que sólo sé que no sé nada.", first: "i", last: "a" },
      { text: "PIenso que sólo sé que no sé nAdA.", first: "e", last: "o" },
      { text: "HOLA MUNDO!", first: "?", last: "?" },
    ]
  end

  def test_first
    @examples.each do |example|
      assert_equal(example[:first], first_or_last(example[:text], true))
    end
  end

  def test_last
    @examples.each do |example|
      assert_equal(example[:last], first_or_last(example[:text], false))
    end
  end

  def test_first_notfound
    @examples.each do |example|
      assert_equal("?", first_or_last(example[:text].upcase , true))
    end
  end

  def test_last_notfound
    @examples.each do |example|
      assert_equal("?", first_or_last(example[:text].upcase , false))
    end
  end
end
