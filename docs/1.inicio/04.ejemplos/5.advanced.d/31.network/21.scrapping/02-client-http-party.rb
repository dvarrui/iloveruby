#!/usr/bin/env ruby
require "HTTParty"

response = HTTParty.get("https://en.wikipedia.org/wiki/Douglas_Adams")
html = response.body

puts html
