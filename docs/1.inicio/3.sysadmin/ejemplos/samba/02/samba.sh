#!/bin/bash
# version 02

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

echo "[INFO] Crear grupos y usuarios"

NUMLINEAS=$(cat /etc/group | grep piratas | wc -l)
if [ $NUMLINEAS == "0" ]; then
  groupadd piratas
  groupadd soldados
  groupadd sambausers
  useradd sambaguest -s /bin/false -G sambausers
  useradd pirata1 -m -s /bin/bash -g piratas -G sambausers
  useradd pirata2 -m -s /bin/bash -g piratas -G sambausers
  useradd soldado1 -m -s /bin/bash -g soldados -G sambausers
  useradd soldado2 -m -s /bin/bash -g soldados -G sambausers
  useradd supersamba -m -s /bin/bash -G piratas,soldados,sambausers
fi
