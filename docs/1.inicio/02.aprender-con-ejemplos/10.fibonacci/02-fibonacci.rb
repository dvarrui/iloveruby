#!/usr/bin/env ruby

def show_usage
  puts "Usage: #{$0} NUMBER"
  exit 1
end

if ARGV.length != 2
  show_usage
end

# 1. Pedir un número al usuario.
number = ARGV[0].to_i
puts "==> number=#{number}"

# 2. Calcular lo N primeros elementos de la sucesión de Fibonacci.
# 3. Mostrar por pantalla
# 4. Escribirlos en un fichero llamado `fibonacci.txt`.
