#!/usr/bin/env ruby

def show_usage
  puts "Usage: #{$0} NUMBER"
  exit 1
end

if ARGV.length != 1
  show_usage
end

number = ARGV.first.to_i

# Dibujar por pantalla los siguientes patrones para un número N leído por teclado.
# 2. Dibujar patrón 1

(number..1).step(-1).each do
  puts "*" * _1
end

# 3. Dibujar cuadrado

puts ' '
line1 = "*" * number
line2 = "*" + ' ' * (number - 2) + "*"

puts line1
(number -2).times { puts line2 }
puts line1

# 4. Dibujar patrón 3
# 5. Dibujar pirámide
