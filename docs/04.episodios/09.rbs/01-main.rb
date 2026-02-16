#!/usr/bin/env ruby

require_relative '01-appsignal'

test = Test.new("My value", "My value" == "")
pp test

test = Super.new(1970)
pp test
