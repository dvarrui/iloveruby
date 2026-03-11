#!/usr/bin/env ruby

require_relative "lib/05-aldi-lib"

URL = "https://www.aldi.es/supermercados/encuentra-tu-supermercado.html"
codes = [ "38670", "38550", "38260", "38611", "35014", "35214", "38639" ]

index = rand(0..codes.size)
puts AldiPhoneNumber.new(URL).get(codes[index])
