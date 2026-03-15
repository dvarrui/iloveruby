#!/usr/bin/env ruby
require_relative "lib/code2code"

c2c = Code2Code.new(ARGV[0])
c2c.show
