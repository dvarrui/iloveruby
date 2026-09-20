#!/usr/bin/env ruby

# A. Leer tres números por argumentos
number1 = ARGV[0].to_i
number2 = ARGV[1].to_i
number3 = ARGV[2].to_i

puts("[input numbers] #{number1} #{number2} #{number3}")

# Ordenamos los números
if number1 > number2 
  # Itercambiar number1 con number2
  number1, number2 = number2, number1
end

if number2 > number3
  # Itercambiar number2 con number3
  number2, number3 = number3, number2
end

if number1 > number2
  # Itercambiar number1 con number2
  number1, number2 = number2, number1
end

# B. Mostrar por pantalla
puts("[order numbers] #{number1} #{number2} #{number3}")

# C. Tenemos el mínimo y el máximo
min = number1
max = number3

puts "[Mínimo] #{min}"
puts "[Máximo] #{max}"

# [TODO] D. Indicar si es par o impar, el mínimo y el máximo
