#!/bin/bash
# version 01

USERNAME="mariano"
HOSTNAME="server02g"
CLIENT1_IP="172.19.2.32"
CLIENT1_HOSTNAME="client02g"
CLIENT2_IP="172.19.2.11"
CLIENT2_HOSTNAME="client02w"

# =======
# step 01
echo "[INFO] Ejecutando el script Samba"
echo "       Tienes que ser el usuario root para que funcione"

if [ $(id $USERNAME|wc -l) == "0" ]; then
   useradd $USERNAME -m -s /bin/bash -g users
fi
hostnamectl set-hostname $HOSTNAME

# =======
# step 02
echo "[INFO] Modificar el fichero /etc/hosts con los clientes"

NUMLINEAS="$(cat /etc/hosts | grep $CLIENT1_IP | wc -l)"
if [ $NUMLINEAS == "0" ]; then
  echo "$CLIENT1_IP     $CLIENT1_HOSTNAME" >> /etc/hosts
  echo "$CLIENT2_IP     $CLIENT2_HOSTNAME" >> /etc/hosts
fi
