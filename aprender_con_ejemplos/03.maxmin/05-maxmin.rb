#!/usr/bin/env ruby

# Leer tres números por argumentos y creamos un Array
numbers = [
  ARGV[0].to_i,
  ARGV[1].to_i,
  ARGV[2].to_i
]

# ¿Ordenamos los números? No hace falta
# Tenemos el mínimo y el máximo
min = numbers.min
max = numbers.max

# Calculamos las paridades
min_parity = min.odd?() ? "impar" : "par"
max_parity = max.odd?() ? "impar" : "par"

# Salida por pantalla
puts "[Mínimo] #{min} (#{min_parity})"
puts "[Máximo] #{max} (#{max_parity})"
