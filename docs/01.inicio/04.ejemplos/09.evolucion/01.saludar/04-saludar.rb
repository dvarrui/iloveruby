#!/usr/bin/env ruby

def hola_a(nombre, linea = nil)
  frase = "¡Hola #{nombre.capitalize}!"
  return frase if linea.nil?

  " #{linea} => ¡Hola #{nombre.capitalize}!"
end

def decir(frase)
  puts frase
end

# ri String#size
if ARGV.size.zero?
    decir '¡Disculpe! ¿Le conozco?'
elsif ARGV.size == 1
  name = ARGV[0].capitalize
  decir "¿Cuantas veces le saludo #{name}?"
elsif ARGV.size == 2
  name = ARGV[0]
  number = ARGV[1].to_i
  number.times { decir hola_a(name) }
else
  name = ARGV[0]
  number = ARGV[1].to_i
  decir 'ESO LOS SERAS TUUUU'
  (1..number).each { |line| decir hola_a(name, line) }
end
