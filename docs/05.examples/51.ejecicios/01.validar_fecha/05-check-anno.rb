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
puts ""

# Validar los datos
#   Validar mes (valor entre 1 y 12)
#   Según el valor del mes sabremos el máximo de días de ese mes (max)
diasmeses = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
if mes < 1 or mes > 12
  puts "[ERROR] MES debe estar entre 1 y 12"
  exit
end

#   Averiguar si año es bisiesto (múltiplo de 4)
bisiesto = (anno % 4) == 0
if bisiesto
  diasmeses[2] = 29
end

#   Validar día (valor entre 1 y max)
maxdias = diasmeses[mes]
if dia < 1 or dia > maxdias
  puts "[ERROR] DIA debe estar entre 1 y #{maxdias}"
  exit
end

# Mostrar resultado
#   Fecha válida o fecha inválida
puts "[ OK ] Fecha #{dia}/#{mes}/#{anno} correcta!"
