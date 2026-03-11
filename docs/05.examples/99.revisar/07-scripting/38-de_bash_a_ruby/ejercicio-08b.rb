#!/usr/bin/env ruby 
# Variables del script

require 'fileutils'

modulos = ["hardware", "ingles", "lenguaje-de-marcas", "sistemas-operativos", "redes"]
current_year = %x[date +%y].chop
next_year = %x[date -d "year" +%y].chop 
curso = "curso" + current_year + next_year

# Comienza el script
puts "[RUBY] Ejecutando " + File.basename($0, ".rb") 
print "Escribe el nombre del ALUMNO: "
alumno = gets.chop

# Borrar el directorio si existe
if File.exist?(curso) 
  FileUtils.rm_r(curso)
end

FileUtils.mkdir(curso)

for i in modulos
  # Esto es lo que se repite
  FileUtils.mkdir("#{curso}/#{i}")

  file = File.open("#{curso}/#{i}/leeme.txt", "w")
  file.write(alumno)
end
