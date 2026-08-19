#!/usr/bin/env ruby

def show_usage
  puts "Usage: #{$0} NUMBER"
  exit 1
end

if ARGV.length != 1
  show_usage
end

number = ARGV.first.to_i
puts "[DEBUG] #{number}"

# Dibujar por pantalla los siguientes patrones para un número N leído por teclado.
# 2. Dibujar patrón 1
# 3. Dibujar cuadrado
# 4. Dibujar patrón 3
# 5. Dibujar pirámide
