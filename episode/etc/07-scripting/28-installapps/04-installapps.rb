#!/usr/bin/env ruby
require_relative '04-installapps-lib'
puts "Executing #{$0}..."

packages = <<-EOF
tree nmap git geany
EOF

if ARGV.first == '-s'
  debug = true
elsif ARGV.first == '-r'
  debug = false
else
  puts "Usage:"
  puts "        #{$0} OPTIONS"
  puts "Options:"
  puts "  -s    => Simulate installation."
  puts "  -r    => Run installation."
  exit 0
end

install packages, debug
