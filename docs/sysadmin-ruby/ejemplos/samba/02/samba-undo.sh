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
echo "[INFO] Ejecutando el script Samba Undo"
echo "       Tienes que ser el usuario root para que funcione"

if [ $(id $USERNAME|wc -l) != "0" ]; then
   userdel $USERNAME -f -r
fi
hostnamectl set-hostname localhost

# =======
# step 02
echo "[INFO] Quitar del fichero /etc/hosts los clientes"

NUMLINEAS="$(cat /etc/hosts | grep $CLIENT1_IP | wc -l)"
#if [ $NUMLINEAS != "0" ]; then
  # Eliminar líneas del ficheros
#fi

echo "[INFO] Borrar grupos y usuarios"

NUMLINEAS=$(cat /etc/group | grep piratas | wc -l)
if [ $NUMLINEAS != "0" ]; then
  userdel sambaguest -f -r
  userdel pirata1 -f -r
  userdel pirata2 -f -r
  userdel soldado1 -f -r
  userdel soldado2 -f -r
  userdel supersamba -f -r
  groupdel piratas
  groupdel soldados
  groupdel sambausers
fi
