#!/usr/bin/env ruby 
# Descripción: crear usuarios, grupos y carpetas con determinados permisos
# Crear funciones para que el código sea más legible
# Adaptar el script para que sirva en GNU/Linux y Windows

require 'fileutils'
require 'os'

def crear_grupo(groupname)
  # GRUPOS: Crear grupo si no existe
  if OS.linux?
    system("cat /etc/group | grep #{groupname} > /dev/null")
    if $? != 0
      system("groupadd #{groupname}")
    end
  elsif OS.windows?
    system("net localgroup #{groupname} /ADD")
  end
end

def get_grupo(username)
  grupo="jedis"
  if username == "sith1" or username == "sith2"
    grupo="siths"
  end
  return grupo
end

def crear_carpeta(username, dirname, permisos)
  # CARPETA: Crear carpeta (username, dirname, permisos)
  if OS.linux?
    ruta = "/home/#{username}/#{dirname}"
  elsif OS.windows?
    ruta = "C:\\Users\\#{username}\\#{dirname}"
  end

  FileUtils.mkdir(ruta)
  FileUtils.chmod(permisos, ruta)

  # Cambiar grupo propietario
  grupo = get_grupo(username)
  FileUtils.chown(username, grupo, ruta)
end

def crear_usuario(username)
  # USUARIO: Crear usuario si no existe
  grupo=get_grupo(username)

  if OS.linux?
    system("cat /etc/passwd | grep #{username} > /dev/null")
    if $? != 0
      system("useradd #{username} -m -g #{grupo}")
      crear_carpeta(username, "private", 0700)
      crear_carpeta(username, "group", 0750)
      crear_carpeta(username, "public", 0755)
    end
  elsif OS.windows?
    system("net user #{username} /add")
    system("net localgroup #{grupo} #{username} /add")
    crear_carpeta(username, "private", 0700)
    crear_carpeta(username, "group", 0750)
    crear_carpeta(username, "public", 0755)
  end
end

# Objetivo:

crear_grupo "jedis"
crear_grupo "siths"

crear_usuario "jedi1"
crear_usuario "jedi2"
crear_usuario "sith1"
crear_usuario "sith2"

