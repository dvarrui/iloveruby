#!/usr/bin/env ruby

ips = [ '192.168.1.1', '192.168.1.42', '192.168.1.33', '192.168.1.100' ]

for ip in ips
  ok = system("ping -c 1 #{ip} > /dev/null")

  if ok
    puts "[ OK ] #{ip}"
  else
    puts "[FAIL] #{ip}"
  end
end
 
