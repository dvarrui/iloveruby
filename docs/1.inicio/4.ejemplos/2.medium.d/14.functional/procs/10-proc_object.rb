#!/usr/bin/env ruby

puts "==== fase 1 ===="

saludar = proc {
  puts "Hola!"
}

puts "[INFO] #{saludar}"
saludar.call

puts "\n==== fase 2 ===="

def run (p)
  puts "[INFO] Vamos a llamar a un procedimiento ..."
  p.call
  puts "[INFO] Finalizado."
end

run(saludar)

