#!/usr/bin/env ruby

require 'test/unit'

# require 'word'
require_relative '../../../lib/words-game/word'

class WordTest < Test::Unit::TestCase
  def test_hello_to_chars
    word = 'hello'
    chars = %w(h e l l o)
    assert_equal chars, Word.to_chars(word)
  end

  def test_123_to_chars
    word = '123'
    chars = %w(1 2 3)
    assert_equal chars, Word.to_chars(word)
  end

  def test_empty_to_chars
    word = ''
    chars = %w()
    assert_equal chars, Word.to_chars(word)
  end
end
