#!/usr/bin/env ruby

loop do
  # Mostrar el menú
  puts "=" * 40
  puts "Menú"
  puts "  i  Introducir 2 números"
  puts "  s  Sumar"
  puts "  r  Restar"
  puts "  m  Multiplicar"
  puts "  d  Dividir"
  puts "  x  Salir"
  puts ""
  print "Escribe tu opción: "
  option = gets.strip

  puts "(Has elegido #{option})"
  puts ""

  if option == "i" then
    puts "-" * 40
    puts "Introduce 2 números, por favor!"
    print "  Número1? "
    number1 = gets.to_i
    print "  Número2? "
    number2 = gets.to_i
    puts "(Ok, entonces number1=#{number1} y number2=#{number2})"
  end
  if option == "x" then
    puts "Bye, bye!"
    exit 0
  end

  print "(Pulsa enter para continuar)"
  gets
end
