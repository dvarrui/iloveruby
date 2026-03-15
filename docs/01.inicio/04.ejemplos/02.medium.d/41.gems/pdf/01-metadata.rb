#!/usr/bin/env ruby

require "pdf/reader"

reader = PDF::Reader.new("demo.pdf")

puts "pdf version : #{reader.pdf_version}"
puts "       info : #{reader.info}"
puts "   metadata : #{reader.metadata}"
puts " page count : #{reader.page_count}"
