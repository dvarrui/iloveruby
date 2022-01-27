#!/usr/bin/env ruby
require_relative '05-installapps-lib'
puts "Executing #{$0}..."

packages = <<-EOF
tree nmap git geany
EOF

debug = parse_options(ARGV)
install packages, debug
