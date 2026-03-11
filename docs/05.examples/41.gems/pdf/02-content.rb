#!/usr/bin/env ruby

require "pdf/reader"

reader = PDF::Reader.new("demo.pdf")

reader.pages.each do |page|
  # puts page.fonts
  puts page.text
  # puts page.raw_content
end
