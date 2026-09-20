#!/usr/bin/env ruby

def show_usage
  puts "Usage: #{$0} NUMBER"
  exit 1
end

if ARGV.length != 1
  show_usage
end

# 1. Recibir un número que represente una cantidad de dinero D, incluyendo céntimos.
money = ARGV[0].to_f
puts "--> [DEBUG] money=#{money}"

# 2. Calcular la mínima cantidad de monedas necesarias para sumar D,
#    suponiendo que tenemos monedas de 2, 1, 0.5, 0.2, 0.1, 0.05, 0.02, y 0.01.
# 3. Mostrar por pantalla la cantidad de cada una de las monedas.

