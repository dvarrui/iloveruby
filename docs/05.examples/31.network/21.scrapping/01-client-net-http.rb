#!/usr/bin/env ruby

require 'open-uri'
require 'net/http'

url = "https://en.wikipedia.org/wiki/Douglas_Adams"
uri = URI.parse(url)

response = Net::HTTP.get_response(uri)
html = response.body

puts html
