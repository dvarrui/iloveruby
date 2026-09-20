#!/usr/bin/env ruby
require "marcel"
require "pathname"

filenames = Dir.glob("private*")

filenames.each do |filename|
  type =  Marcel::MimeType.for Pathname.new(filename)
  puts "#{type.rjust(30)}: #{filename}"
end

