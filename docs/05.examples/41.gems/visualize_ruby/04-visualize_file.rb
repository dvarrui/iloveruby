#!/usr/bin/env ruby

require "visualize_ruby"

filepath = ARGV.first
filename = File.basename(filepath, ".rb")
ruby_code = File.read(filepath)

VisualizeRuby.new do |vb|
  vb.ruby_code = ruby_code # String, File, Pathname
  vb.output_path = "flow_#{filename}.png"
end
