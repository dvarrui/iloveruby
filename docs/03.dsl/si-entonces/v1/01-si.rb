#!/usr/bin/env ruby
require_relative "lib/si-entonces-sino-v1"

number = 10
puts si { number > 3 }
puts si { number ==  4 }
