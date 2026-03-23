#!/usr/bin/env ruby
require "pastel"

def show_usage
  puts "Usage: #{$0} NUMBER"
  exit 1
end

if ARGV.length != 1
  show_usage
end

# 1. Recibir un número que represente una cantidad de dinero D, incluyendo céntimos.
money = ARGV[0].to_f

# 2. Calcular la mínima cantidad de monedas necesarias para sumar D,
#    suponiendo que tenemos monedas de 2, 1, 0.5, 0.2, 0.1, 0.05, 0.02, y 0.01.
coins = [2, 1, 0.5, 0.2, 0.1, 0.05, 0.02, 0.01]
coins.sort!.reverse!
change = {}

amount = money
coins.each do |coin|
  while amount >= coin
    change[coin] ||= 0
    change[coin] += 1
    amount -= coin
    amount = amount.round(2)
  end  
end

# 3. Mostrar por pantalla la cantidad de cada una de las monedas.
pastel = Pastel.new
puts "La cantidad de dinero #{pastel.yellow.bold(money)} se puede cambiar a:"
change.each_pair do |coin, number|
  plural = "s"
  plural = " " if number == 1
  puts "* #{pastel.green.bold(number)} moneda#{plural} de #{coin}"  
end
