#!/usr/bin/env ruby
# version 03 ruby

clients = [
  { ip: "172.19.2.32", hostname: "client02g" },
  { ip: "172.19.2.11", hostname: "client02w" }
]

puts "[INFO] Modificar el fichero /etc/hosts con los clientes"

#clients.each do |client|
for client in clients
  numlineas=`cat /etc/hosts | grep #{client[:ip]} | wc -l`.to_i
  puts numlineas
  if numlineas == 0
    puts "echo #{client[:ip]}     #{client[:hostname]} >> /etc/hosts"
  end
end
