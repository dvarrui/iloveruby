#!/bin/bash
# Descripción: crear usuarios, grupos y carpetas con determinados permisos
USUARIOS="jedi1 jedi2 sith1 sith2"

# 01. GRUPOS: Crear los grupos si no existen
for i in jedis siths
do
  cat /etc/group | grep $i > /dev/null
  if [ $? -ne 0 ]
  then
    groupadd $i
  fi
done

# 02. USUARIOS: Crear los usuarios jedis o siths si no existen
for i in $USUARIOS
do
  GRUPO="jedis"
  if [[ $i == "sith1" || $i == "sith2" ]]
  then 
    GRUPO="siths"
  fi

  cat /etc/passwd | grep $i > /dev/null
  if [ $? -ne 0 ]
  then
    useradd $i -m -g $GRUPO
  fi
done

# 03. CARPETAS: Crear carpetas: private, group, public
for i in $USUARIOS 
do
  # Crear la carpeta private	
  mkdir /home/$i/private
  chmod 700 /home/$i/private
  chown $i /home/$i/private
  # Crear la carpeta group
  mkdir /home/$i/group
  chmod 750 /home/$i/group
  chown $i /home/$i/group
  # Crear la carpeta public
  mkdir /home/$i/public
  chmod 755 /home/$i/public
  chown $i /home/$i/public

  # Cambiar grupo propietario
  GRUPO="jedis"
  if [[ $i == "sith1" || $i == "sith2" ]]
  then
    GRUPO="siths"
  fi
  chgrp $GRUPO /home/$i/private
  chgrp $GRUPO /home/$i/group
  chgrp $GRUPO /home/$i/public
done
