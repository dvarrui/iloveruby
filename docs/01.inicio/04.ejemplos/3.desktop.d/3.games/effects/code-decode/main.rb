#!/usr/bin/env ruby
require_relative "lib/code2code"
require "debug"

c2c = Code2Code.new(ARGV[0])
c2c.code
c2c.show
