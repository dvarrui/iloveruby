#!/usr/bin/env ruby
require_relative "lib/si-entonces-sino-v1"

number = 10

si('number >= 18')
  .entonces('puts "Adulto"')
  .sino('puts "Menor"')
