#!/usr/bin/env ruby
require 'drb/drb'

name = ARGV.first || "Client#{rand(9)}"
there = DRbObject.new_with_uri('druby://localhost:12345')
there.puts("#{name}: Hello, World.")
