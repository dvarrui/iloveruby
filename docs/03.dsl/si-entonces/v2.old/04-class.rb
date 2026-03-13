#!/usr/bin/env ruby
require_relative "lib/si-entonces-sino-v2"

number = 10

si('number >= 18', binding)
  .entonces('puts "Adulto"')
  .sino('puts "Menor"')
