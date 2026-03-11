#!/usr/bin/env ruby

require_relative 'lib/saludar05'

nombre = ARGV[0]

if ARGV.size.zero?
    decir '¡Disculpe! ¿Le conozco?'
elsif ARGV.size == 1
  preguntar_a nombre.capitalize
else
  number = ARGV[1].to_i
  if ARGV.size == 2
    number.times { decir hola_a(nombre) }
  else
    decir 'ESO LO SERAS TU'
    (1..number).each { |cadavez| decir hola_a(nombre, cadavez) }
  end
end
