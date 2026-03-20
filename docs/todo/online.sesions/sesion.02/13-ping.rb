#!/usr/bin/env ruby

require 'colorize'

ips = [ '192.168.1.1', '192.168.1.42', '192.168.1.33', '192.168.1.100' ]

while(true)
  # Check all IPS
  for ip in ips.sort
    # Check 1 IP
    ok = system("ping -c 1 #{ip} > /dev/null")

    if ok
      puts "[ OK ] #{ip}".white
    else
      puts "[FAIL] #{ip}".light_red
    end
  end
  sleep 5
  system("clear")
end
 
