#!/usr/bin/env ruby

def show_usage
  puts "Usage: #{$0} NUMBER1 NUMBER2"
  exit 1
end

if ARGV.length != 2
  show_usage
end

# 1. Pedir al usuario dos números enteros N y M.
n = ARGV[0].to_i
m = ARGV[1].to_i

# 2. Calcular el máximo común divisor (MCD) de N y M.
mcd = n.gcd(m)

# 3. Mostrar por pantalla em MCD.
puts "Numbers:"
puts "- n   = #{n}"
puts "- m   = #{m}"
puts "Results:"
puts "- MCD = #{mcd}"

# 4. Calcular y mostrar por pantalla el mínimo común múltiplo (MCM) de N y M.
# Usando un método integrado
mcm = n.lcm(m)
puts "- MCM = #{mcm}"

# 5. Hacer lo mismo pero pidiendo varios números al usuario.
# 6. Almacenar en una lista y calcular el MCM y el MCD de todos ellos.
