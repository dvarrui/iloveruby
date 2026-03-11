#!/usr/bin/env ruby
require_relative "lib/04-sino"

number = 10

si { number >= 18 }
  entonces { puts "Adulto" }
  sino { puts "Menor" }


number = 52

si { number >= 18 }
entonces {
  puts "Adulto"
}; sino {
  puts "Menor"
}
