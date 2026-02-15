#!/usr/bin/env ruby

def show_usage
  puts "Usage: #{$0} VALUE ACTION"
  puts "  Action debe ser: dec2bin, bin2dec o oct2hex"
  exit 1
end

if ARGV.length != 2 
  show_usage
end

# Pasar por argumentos
# 1. Un texto con el valor original
# 2. Un indicador de la acción a realizar
value = ARGV[0]
action = ARGV[1].to_sym

# Conversión
if action == :dec2bin
  puts value.to_i.to_s(2)
else
  show_usage
end