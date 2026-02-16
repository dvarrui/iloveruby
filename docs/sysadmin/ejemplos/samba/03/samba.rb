#!/usr/bin/env ruby
# version 02 ruby

username="mariano"
hostname="server02g"
clients = [
  { ip: "172.19.2.32", hostname: "client02g" },
  { ip: "172.19.2.11", hostname: "client02w" }
]
groups = [ 'piratas', 'soldados', 'sambausers']
users = [ 'pirata1', 'pirata2', 'soldado1', 'soldado2', 'supersamba', 'sambaguest' ]

# =======
# step 01: crear usuario y poner hostname
def step01(username, hostname)
  puts "[INFO] Ejecutando el script Samba"
  puts "       Tienes que ser el usuario root para que funcione"

  numlineas = `id #{username}|wc -l`.to_i
  if numlineas == 0
    system("useradd #{username} -m -s /bin/bash -g users")
  end
  system("hostnamectl set-hostname #{hostname}")
end

# =======
# step 02: modificar el fichero /etc/hosts
def step02(clients)
  puts "[INFO] Modificar el fichero /etc/hosts con los clientes"

  for client in clients do
    numlineas=`cat /etc/hosts | grep #{client[:ip]} | wc -l`.to_i
    if numlineas == 0
      system( "echo #{client[:ip]}     #{client[:hostname]} >> /etc/hosts" )
    end
  end
end

# =======
# step 03: crear ususarios y grupos
def step03(groups, users)
  puts "[INFO] Crear grupos y usuarios"

  numlineas=`cat /etc/group | grep piratas | wc -l`.to_i
  if numlineas == 0
    for group in groups do system("groupadd #{group}") end
    for name in users do system("useradd #{name} -m -s /bin/bash") end
  end
end

step01(username, hostname)
step02(clients)
step03(groups, users)
