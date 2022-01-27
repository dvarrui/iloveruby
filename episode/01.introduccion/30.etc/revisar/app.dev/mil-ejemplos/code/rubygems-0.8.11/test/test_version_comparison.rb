#---
# Excerpted from "Everyday Scripting in Ruby"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bmsft for more book information.
#---
require 'test/unit'
require 'rubygems'
Gem::manage_gems

module VersionAsserts
  def assert_adequate(version, requirement)
    ver = Gem::Version.new(version)
    req = Gem::Version::Requirement.new(requirement)
    assert req.satisfied_by?(ver),
      "Version #{version} should be adequate for Requirement #{requirement}"
  end

  def assert_inadequate(version, requirement)
    ver = Gem::Version.new(version)
    req = Gem::Version::Requirement.new(requirement)
    assert ! req.satisfied_by?(ver),
      "Version #{version} should not be adequate for Requirement #{requirement}"
  end
end


class Versions < Test::Unit::TestCase
  include VersionAsserts

  def test_ok
      assert_adequate( "0.2.33",      "= 0.2.33")
      assert_adequate( "0.2.34",      "> 0.2.33")
      assert_adequate( "1.0",         "= 1.0")
      assert_adequate( "1.0",         "1.0")
      assert_adequate( "1.8.2",       "> 1.8.0")
      assert_adequate( "1.112",       "> 1.111")
      assert_adequate( "0.2",         "> 0.0.0")
      assert_adequate( "0.0.0.0.0.2", "> 0.0.0")
      assert_adequate( "0.0.1.0",     "> 0.0.0.1")
      assert_adequate( "10.3.2",      "> 9.3.2")
      assert_adequate( "1.0.0.0",     "= 1.0")
      assert_adequate( "10.3.2",      "!= 9.3.4")
      assert_adequate( "10.3.2",      "> 9.3.2")
      assert_adequate( "10.3.2",      "> 9.3.2")
      assert_adequate( " 9.3.2",      ">= 9.3.2")
      assert_adequate( "9.3.2 ",      ">= 9.3.2")
      assert_adequate( "",            "= 0")
      assert_adequate( "",            "< 0.1")
      assert_adequate( "  ",          "< 0.1 ")
      assert_adequate( "",            " <  0.1")
      assert_adequate( "0",           "=")
      assert_adequate( "0",           ">=")
      assert_adequate( "0",           "<=")
    end

    def test_bad
      assert_inadequate( "",            "> 0.1")
      assert_inadequate( "1.2.3",       "!= 1.2.3")
      assert_inadequate( "1.2.003.0.0", "!= 1.02.3")
      assert_inadequate( "4.5.6",       "< 1.2.3")
      assert_inadequate( "1.0",         "> 1.1")
      assert_inadequate( "0",           ">")
      assert_inadequate( "0",           "<")
      assert_inadequate( "",            "= 0.1")
      assert_inadequate( "1.1.1",       "> 1.1.1")
      assert_inadequate( "1.2",         "= 1.1")
      assert_inadequate( "1.40",        "= 1.1")
      assert_inadequate( "1.3",         "= 1.40")
      assert_inadequate( "9.3.3",       "<= 9.3.2")
      assert_inadequate( "9.3.1",       ">= 9.3.2")
      assert_inadequate( "9.3.03",      "<= 9.3.2")
      assert_inadequate( "1.0.0.1",     "= 1.0")
    end

    def test_illformed_version
      [ "blah", "1.3.a", "1.3.5." ].each do |wn|
	assert_raises(ArgumentError) { Gem::Version.new(wn) }
      end
    end

    def test_illformed_requirements
      [ ">>> 1.3.5", "> blah" ].each do |rq|
	assert_raises(ArgumentError, "req [#{rq}] should fail") {
	  Gem::Version::Requirement.new(rq)
	}
      end
    end
end

class TestVersion < Test::Unit::TestCase
  def test_to_s
    v = Gem::Version.new("5.2.4")
    assert_equal "5.2.4", v.to_s
  end
  def test_bump
    v = Gem::Version.new("5.2.4")
    assert_equal "5.3", v.bump.to_s
  end
  def test_bump_one_level
    v = Gem::Version.new("5")
    assert_equal "6", v.bump.to_s
  end
end
    

class TestExtendedVersionComparisons < Test::Unit::TestCase
  include VersionAsserts

  def test_multiple
    req = [">= 1.4", "<= 1.6", "!= 1.5"]
    assert_inadequate("1.3", req)
    assert_adequate(  "1.4", req)
    assert_inadequate("1.5", req)
    assert_adequate(  "1.6", req)
    assert_inadequate("1.7", req)
    assert_inadequate("2.0", req)
  end

  def test_boxed
    assert_inadequate("1.3", "~> 1.4")
    assert_adequate(  "1.4", "~> 1.4")
    assert_adequate(  "1.5", "~> 1.4")
    assert_inadequate("2.0", "~> 1.4")
  end

end

class TestDependencies < Test::Unit::TestCase
  def test_create
    dep = Gem::Dependency.new("pkg", ["> 1.0"])
    assert_equal "pkg", dep.name
    assert_equal Gem::Version::Requirement.new(["> 1.0"]), dep.version_requirements
  end

  def test_create_single
    dep = Gem::Dependency.new("pkg", "> 1.0")
    assert_equal Gem::Version::Requirement.new(["> 1.0"]), dep.version_requirements
  end

  def test_create_double
    dep = Gem::Dependency.new("pkg", ["> 1.0", "< 2.0"])
    assert_equal Gem::Version::Requirement.new(["> 1.0", "< 2.0"]), dep.version_requirements
  end

  def test_create_wacked
    require 'yaml'
    dep = Gem::Dependency.new("pkg", [])
    old_req = Gem::Version::Requirement.new(["> 1.0"])
    old_req.instance_eval do
      @version = ">= 1.0"
      @op = ">="
      @nums = [1,0]
      @requirements = nil
    end
    dep.instance_eval do
      @version_requirement = old_req
      @version_requirements = nil
    end
    assert_equal Gem::Version::Requirement.new([">= 1.0"]), dep.version_requirements
  end

  def test_create_from_string
    req = Gem::Version::Requirement.create(">1")
    assert ! req.satisfied_by?(Gem::Version.new("1.0"))
    assert req.satisfied_by?(Gem::Version.new("1.1"))
  end

  def test_create_from_string_equal
    req = Gem::Version::Requirement.create("1.3")
    assert ! req.satisfied_by?(Gem::Version.new("1.0"))
    assert req.satisfied_by?(Gem::Version.new("1.3"))
  end

  def test_create_from_requirement
    req = Gem::Version::Requirement.create(Gem::Version::Requirement.new("1.3"))
    assert ! req.satisfied_by?(Gem::Version.new("1.0"))
    assert req.satisfied_by?(Gem::Version.new("1.3"))
  end

  def test_compare_to_nil
    assert(Gem::Version.new("0.0") > nil)
    req = Gem::Version::Requirement.create("1.3")
    assert ! req.satisfied_by?(nil)
  end

  def test_create_from_list
    req = Gem::Version::Requirement.create([">1", "<2"])
    assert ! req.satisfied_by?(Gem::Version.new("1.0"))
    assert ! req.satisfied_by?(Gem::Version.new("2.0"))
    assert req.satisfied_by?(Gem::Version.new("1.3"))
  end

  # We may get some old gems that have requirements in old formats.
  # We need to be able to handle those old requirements by normalizing
  # them to the latest format.
  def test_normalization
    require 'yaml'
    yamldep = %{--- !ruby/object:Gem::Version::Requirement
      nums: 
        - 1
        - 0
        - 4
      op: ">="
      version: ">= 1.0.4"}
    dep = YAML.load(yamldep)
    dep.normalize
    assert_equal ">= 1.0.4", dep.to_s
  end
end
