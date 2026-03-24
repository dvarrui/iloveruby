#!/usr/bin/env ruby

puts "Executing #{$0}..."
packages = ['tree', 'nmap', 'git', 'geany']

if ARGV.first == '-s'
  packages.each { |package| puts "zypper install -y #{package}" }
elsif ARGV.first == '-r'
  system('zypper refresh')
  packages.each { |package| system("zypper install -y #{package}") }
else
  puts "Usage:"
  puts "        #{$0} OPTIONS"
  puts "Options:"
  puts "  -s    => Simulate installation."
  puts "  -r    => Run installation."
  exit 0
end
