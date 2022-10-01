#!/usr/bin/env ruby

ips = [ '192.168.1.1', '192.168.1.42', '192.168.1.33', '192.168.1.100' ]

for ip in ips
  system("ping -c 1 #{ip}")
end
 
