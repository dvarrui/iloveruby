#! /usr/bin/env ruby
# https://kgilmersden.wordpress.com/2010/09/30/call-your-java-method-from-your-ruby-class/

require 'java'
require_relative 'test.jar'

class Main
 def run
  sayObj = Java::Test::Test.new
  sayObj.say()
 end
end

app = Main.new
app.run
