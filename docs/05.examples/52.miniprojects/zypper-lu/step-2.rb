#!/usr/bin/env ruby

input = File.readlines("list2.txt")
puts input.size

names = []
input.each do |name|
  exit if File.exist? "stop"
  if names.size < 10
    names << name.strip
  else
    cmd = "sudo zypper update -y #{names.join(" ")}"
    puts cmd
    names = []
  end
end
# File.open("list2.txt").each do |packname|
  # cmd = "sudo zypper update -y #{packname}"
  # system(cmd)
# end
