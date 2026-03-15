#!/usr/bin/env ruby
#

require 'colorize'

logo = File.read(ARGV[0])

puts logo.light_blue
