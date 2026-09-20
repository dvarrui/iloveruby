#!/usr/bin/env ruby
require "yaml"

filename = "config.yaml"
content = File.read(filename)
data = YAML.load(content)

puts "data = #{data}"

for i in data
  puts "* #{i[0].rjust(6)} = #{i[1]}"
end

puts data.fetch("str", :none)
puts data.fetch("str2", :none)

