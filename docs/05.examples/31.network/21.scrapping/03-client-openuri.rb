#!/usr/bin/env ruby

require 'open-uri'

file = URI.open("https://en.wikipedia.org/wiki/Douglas_Adams")
html = file.read
puts html

