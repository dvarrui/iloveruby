#!/usr/bin/env ruby

loop do
  # Mostrar el menú
  puts "=" * 40
  puts "Menú"
  puts "i. Introducir 2 números"
  puts "s. Sumar"
  puts "r. Restar"
  puts "m. Multiplicar"
  puts "d. Dividir"
  puts "s. Salir"
  puts ""
  print "Escribe tu opción: "
  option = gets.strip

  puts "Has elegido " + option

  if option == "s" then
    exit 0
  end
end
