#!/usr/bin/env ruby
require_relative "lib/si-entonces-sino-v1"

number = 10

si (number > 3)
  entonces { puts "Number > 3" }

si (number ==  4)
  entonces { puts "Number == 4" }
