#!/usr/bin/env ruby
#---
# Excerpted from "Everyday Scripting in Ruby"
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/bmsft for more book information.
#---

require 'test/unit'
require 'rubygems/cmd_manager'
require 'rubygems/user_interaction'
require 'test/mockgemui'

class TestSpecificExtras < Test::Unit::TestCase
  include Gem::DefaultUserInteraction

  def setup
    @cm = Gem::CommandManager.new
    @cmd = @cm['rdoc']
  end

  
  def test_add_extra_args
    added_args = ["--all"]
    command = "rdoc"
    Gem::Command.add_specific_extra_args command, added_args

    assert_equal(added_args, Gem::Command.specific_extra_args(command))

    Gem::Command.instance_eval "public :add_extra_args"
    h = @cmd.add_extra_args([])
    assert_equal(added_args,h)
  end
  
  def test_add_extra_args_unknown
    added_args = ["--definitely_not_there"]
    command = "rdoc"
    Gem::Command.add_specific_extra_args command, added_args

    assert_equal(added_args, Gem::Command.specific_extra_args(command))

    Gem::Command.instance_eval "public :add_extra_args"
    h = @cmd.add_extra_args([])
    assert_equal([],h)
  end
end
