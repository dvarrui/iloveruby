#!/usr/bin/env ruby

File.open("list1.txt").each do |line|
  fields = line.split("|")
  next if fields.size < 2

  state = fields[0].strip
  packname = fields[2].strip
  if state == "v" && packname < "gpart"
    puts packname
  end
end
