#!/usr/bin/env ruby

require_relative 'lib/02-appsignal'

test = Test.new("My value", "My value" == "")
pp test

test = Super.new("My value")
pp test
