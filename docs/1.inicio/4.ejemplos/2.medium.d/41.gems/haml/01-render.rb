#!/usr/bin/env ruby 

require "haml"

filename = ARGV.first
content = File.read(filename)
template = Haml::Template.new { content }.render

puts template
