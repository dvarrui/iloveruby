#!/usr/bin/env ruby

puts "Executing #{$0}..."

system('zypper refresh')
system('zypper install -y tree')
system('zypper install -y nmap')
system('zypper install -y git')
system('zypper install -y geany')
