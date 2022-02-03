#!/usr/bin/env ruby

#require 'rbs'
require_relative 'lib/03-appsignal'

test = Test.new("My value", 1970)
pp test

test = Super.new("My value")
pp test
