#!/usr/bin/env ruby

def aplicar(nombre)
  puts "Antes..."
  # 'yield' ejecuta el bloque de código enviado al método
  yield(nombre) 
  puts "...después"
  puts ""
end
  
aplicar("Luke") { |name| puts "#{name}: ¡Que la fuerza te acompañe!" }

aplicar("Trooper") { |name| puts "Disparar a #{name}" }
