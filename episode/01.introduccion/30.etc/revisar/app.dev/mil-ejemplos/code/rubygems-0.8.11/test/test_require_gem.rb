#!/usr/bin/env ruby
#---
# Excerpted from "Everyday Scripting in Ruby"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bmsft for more book information.
#---

require 'test/unit'
require 'test/gemenvironment'

class TestRequireGem < Test::Unit::TestCase
  def setup
    TestEnvironment.create
    Gem.use_paths("test/data/gemhome")
    Gem.source_index.refresh!
    @old_path = $:.dup
    Gem.instance_eval { @loaded_specs.clear if @loaded_specs }
  end

  def teardown
    $:.replace(@old_path)
  end

  def test_require
    assert require_gem('a', '= 0.0.1'), "Should load"
    assert $:.any? { |p| %r{a-0.0.1/lib} =~ p }
    assert $:.any? { |p| %r{a-0.0.1/bin} =~ p }
  end

  def test_redundent_requires
    assert require_gem('a', '= 0.0.1'), "Should load"
    assert ! require_gem('a', '= 0.0.1'), "Should not load"
    assert_equal 1, $:.select { |p| %r{a-0.0.1/lib} =~ p }.size
    assert_equal 1, $:.select { |p| %r{a-0.0.1/bin} =~ p }.size
  end

  def test_overlapping_requires
    assert require_gem('a', '= 0.0.1'), "Should load"
    assert ! require_gem('a', '>= 0.0.1'), "Should not load"
    assert_equal 1, $:.select { |p| %r{a-0.0.1/lib} =~ p }.size
    assert_equal 1, $:.select { |p| %r{a-0.0.1/bin} =~ p }.size
  end

  def test_conflicting_requires
    assert require_gem('a', '= 0.0.1'), "Should load"
    ex = assert_raises(Gem::Exception) { 
      require_gem 'a', '= 0.0.2'
    }
    assert_match /activate a \(= 0\.0\.2\)/, ex.message
    assert_match /activated a-0\.0\.1/, ex.message
    assert $:.any? { |p| %r{a-0.0.1/lib} =~ p }
    assert $:.any? { |p| %r{a-0.0.1/bin} =~ p }
    assert ! $:.any? { |p| %r{a-0.0.2/lib} =~ p }
    assert ! $:.any? { |p| %r{a-0.0.2/bin} =~ p }
  end
end
