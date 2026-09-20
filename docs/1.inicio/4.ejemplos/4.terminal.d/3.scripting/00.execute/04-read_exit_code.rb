#!/usr/bin/env ruby

puts system("ping 192.168.1.1 -c 1 > /dev/null")
puts $?.exitstatus
puts system("ping 192.168.16.16 -c 1 > /dev/null")
puts $?.exitstatus
