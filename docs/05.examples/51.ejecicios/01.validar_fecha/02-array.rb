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

# Validar los datos
puts ""
puts "(Vamos a validar la fecha #{dia}/#{mes}/#{anno})"

#   Validar mes (valor entre 1 y 12)
#   Según el valor del mes sabremos el máximo de días de ese mes (max)
diasmeses = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

maxdias = diasmeses[mes]

puts "(Días del mes=#{maxdias})"

#   Averiguar si año es bisiesto (múltiplo de 4)
#   Validar día (valor entre 1 y max)

# Mostrar resultado
#   Fecha válida o fecha inválida
