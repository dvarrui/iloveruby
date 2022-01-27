#!/bin/bash
# Descripción: crear usuarios, grupos y carpetas con determinados permisos
# Crear funciones para que el código sea más legible

function crear_grupo {
  # GRUPOS: Crear grupo si no existe
  cat /etc/group | grep $1 > /dev/null
  if [ $? -ne 0 ]
  then
    groupadd $1
  fi
}

function crear_carpeta {
  # CARPETA: Crear carpeta (username, dirname, permisos)
  mkdir /home/$1/$2
  chmod $3 /home/$1/$2
  chown $1 /home/$1/$2

  # Cambiar grupo propietario
  GRUPO="jedis"
  if [[ $1 == "sith1" || $1 == "sith2" ]]
  then
    GRUPO="siths"
  fi
  chgrp $GRUPO /home/$1/$2
}

function crear_usuario {
  # USUARIO: Crear usuario si no existe
  GRUPO="jedis"
  if [[ $1 == "sith1" || $1 == "sith2" ]]
  then 
    GRUPO="siths"
  fi

  cat /etc/passwd | grep $1 > /dev/null
  if [ $? -ne 0 ]
  then
    useradd $1 -m -g $GRUPO
    crear_carpeta $1 "private" "700"
    crear_carpeta $1 "group" "750"
    crear_carpeta $1 "public" "755"
  fi
}

# Objetivo:

crear_grupo "jedis"
crear_grupo "siths"

crear_usuario "jedi1"
crear_usuario "jedi2"
crear_usuario "sith1"
crear_usuario "sith2"

