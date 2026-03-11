#!/usr/bin/env ruby

require_relative 'lib/saludar06'

nombre = ARGV[0]

if ARGV.size.zero?
  saludar_a_desconocido
elsif ARGV.size == 1
  saludar_a nombre
else
  number = ARGV[1].to_i
  if ARGV.size == 2
    saludar_n_veces_a(nombre: nombre, veces: number)
  else
    decir "¿#{ARGV[2]}?... eso LO SERAS TU!"
    saludar_enfadado_n_veces_a(nombre: nombre, veces: number)
  end
end
