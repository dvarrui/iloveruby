#!/usr/bin/env ruby

require "colorize"

puts "red".colorize(:red)
puts "blue".colorize(:blue)
puts "light_blue".colorize(:light_blue)

puts "background green".colorize(:background => :green)
puts "underlines".on_blue.underline
