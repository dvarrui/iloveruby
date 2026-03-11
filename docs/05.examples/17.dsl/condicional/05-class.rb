#!/usr/bin/env ruby
require_relative "lib/05-class"

number = 10

si('number >= 18', binding)
  .entonces('puts "Adulto"')
  .sino('puts "Menor"')
