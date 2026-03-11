#!/usr/bin/env ruby
require "mimemagic"

filenames = Dir.glob("private.*")

filenames.each do |filename|
  data = File.open(filename)
  begin
    type = MimeMagic.by_magic(data).type
  rescue
    type = "Error"
  end
  puts "#{type.rjust(30)}: #{filename}"
end

