#!/usr/bin/env ruby

require "rainbow"

puts Rainbow("red").red
puts Rainbow("blue").blue
puts Rainbow("light_blue").blue.bright

puts Rainbow("background green").bg(:green)
puts Rainbow("underlines").underline.blue
