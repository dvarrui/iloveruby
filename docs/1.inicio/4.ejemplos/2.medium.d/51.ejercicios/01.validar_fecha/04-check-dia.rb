#!/usr/bin/env ruby

puts "Programa para validar fechas"
puts ""

puts "Introducir valores"
print "  día? "
dia = gets.to_i
print "  mes? "
mes = gets.to_i
print "  año? "
anno = gets.to_i
puts "(Vamos a validar la fecha #{dia}/#{mes}/#{anno})"
puts ""

# Validar los datos
#   Validar mes (valor entre 1 y 12)
#   Según el valor del mes sabremos el máximo de días de ese mes (max)
diasmeses = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
if mes < 1 or mes > 12
  puts "[ERROR] El valor del MES es incorrecto!"
  exit
end

maxdias = diasmeses[mes]
if dia < 1 or dia > maxdias
  puts "[ERROR] El valor del DIA es incorrecto!"
  exit
end

#   Averiguar si año es bisiesto (múltiplo de 4)
#   Validar día (valor entre 1 y max)

# Mostrar resultado
#   Fecha válida o fecha inválida
