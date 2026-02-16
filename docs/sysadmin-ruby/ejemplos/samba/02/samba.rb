#!/usr/bin/env ruby
# version 02 ruby

username="mariano"
hostname="server02g"
client1_ip="172.19.2.32"
client1_hostname="client02g"
client2_ip="172.19.2.11"
client2_hostname="client02w"

# =======
# step 01
puts "[INFO] Ejecutando el script Samba"
puts "       Tienes que ser el usuario root para que funcione"

numlineas = `id #{username}|wc -l`.to_i
if numlineas == 0
   system("useradd #{username} -m -s /bin/bash -g users")
end
system("hostnamectl set-hostname #{hostname}")

# =======
# step 02
puts "[INFO] Modificar el fichero /etc/hosts con los clientes"

numlineas=`cat /etc/hosts | grep #{client1_ip} | wc -l`.to_i
if numlineas == 0
  system("echo #{client1_ip}     #{client1_hostname} >> /etc/hosts")
  system("echo #{client2_ip}     #{client2_hostname} >> /etc/hosts")
end

puts "[INFO] Crear grupos y usuarios"

numlineas=`cat /etc/group | grep piratas | wc -l`.to_i
if numlineas == 0
  system("groupadd piratas")
  system("groupadd soldados")
  system("groupadd sambausers")
  system("useradd sambaguest -s /bin/false -G sambausers")
  system("useradd pirata1 -m -s /bin/bash -g piratas -G sambausers")
  system("useradd pirata2 -m -s /bin/bash -g piratas -G sambausers")
  system("useradd soldado1 -m -s /bin/bash -g soldados -G sambausers")
  system("useradd soldado2 -m -s /bin/bash -g soldados -G sambausers")
  system("useradd supersamba -m -s /bin/bash -G piratas,soldados,sambausers")
end
