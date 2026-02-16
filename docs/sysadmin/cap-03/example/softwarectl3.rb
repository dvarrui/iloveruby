#!/usr/bin/env ruby

##
# Check input arguments
if ARGV.empty?
  puts "Usage: #{$0} FILENAME"
  puts "       FILENAME is a text file with a list of package names."
  exit 1
end

##
# Read input file
packages = %x[cat #{ARGV.first}].split("\n")

##
# Install packages
packages.each do |package|
  ok = system("zypper install -y #{package}")
  unless ok
    puts "[ERROR] Package '#{package}' not installed!"
  end
end
