#!/usr/bin/env ruby

require 'optparse'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: example.rb [options]"

  opts.on("-v", "--[no-]verbose", "Run verbosely") do |v|
    options[:verbose] = v
  end
end.parse!

if options.empty?
  puts "Usage: #{$0} --help"
  exit 1
end 

puts "==> Your inputs:"
puts "    Options : #{options}"
puts "    ARGV    : #{ARGV}"

