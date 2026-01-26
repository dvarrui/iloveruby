#!/usr/bin/env ruby

# Leer tres números por argumentos
number1 = ARGV[0].to_i
number2 = ARGV[1].to_i
number3 = ARGV[2].to_i

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

# Tenemos el mínimo y el máximo
min = number1
max = number3

# Calculamos las paridades
min_parity = min.odd?() ? "impar" : "par"
max_parity = max.odd?() ? "impar" : "par"

# Salida por pantalla
puts "[Mínimo] #{min} (#{min_parity})"
puts "[Máximo] #{max} (#{max_parity})"
