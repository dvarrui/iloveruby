#!/usr/bin/env ruby 
# Descripción: crear usuarios, grupos y carpetas con determinados permisos
# Crear funciones para que el código sea más legible

def crear_grupo(groupname)
  # GRUPOS: Crear grupo si no existe
  system("cat /etc/group | grep #{groupname} > /dev/null")
  if $? != 0
    system("groupadd #{groupname}")
  end
end

def crear_carpeta(username, dirname, permisos)
  # CARPETA: Crear carpeta (username, dirname, permisos)
  ruta = "/home/#{username}/#{dirname}"
  system("mkdir #{ruta}")
  system("chmod #{permisos} #{ruta}")
  system("chown #{username} #{ruta}")

  # Cambiar grupo propietario
  grupo="jedis"
  if username == "sith1" or username == "sith2"
    grupo="siths"
  end
  system("chgrp #{grupo} #{ruta}")
end

def crear_usuario(username)
  # USUARIO: Crear usuario si no existe
  grupo="jedis"
  if username == "sith1" or username == "sith2"
    grupo="siths"
  end

  system("cat /etc/passwd | grep #{username} > /dev/null")
  if $? != 0
    system("useradd #{username} -m -g #{grupo}")
    crear_carpeta(username, "private", "700")
    crear_carpeta(username, "group", "750")
    crear_carpeta(username, "public", "755")
  end
end

# Objetivo:

crear_grupo "jedis"
crear_grupo "siths"

crear_usuario "jedi1"
crear_usuario "jedi2"
crear_usuario "sith1"
crear_usuario "sith2"

