#!/usr/bin/env ruby

require 'colorize'

ips = [ '192.168.1.1', '192.168.1.42', '192.168.1.33', '192.168.1.100' ]

for ip in ips.sort
  ok = system("ping -c 1 #{ip} > /dev/null")

  if ok
    puts "[ OK ] #{ip}".white
  else
    puts "[FAIL] #{ip}".light_red
  end
end
 
