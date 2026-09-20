#!/usr/bin/env ruby

# Inicializar variables
number1=0
number2=0

loop do
  # Mostrar el menú
  puts "=" * 40
  puts "Menú"
  puts "  i  Introducir números"
  puts "     number1 = #{number1}, number2 = #{number2}"
  puts "  s  Sumar"
  puts "  r  Restar"
  puts "  m  Multiplicar"
  puts "  d  Dividir"
  puts "  x  Salir"
  puts ""
  print "Escribe tu opción: "
  option = gets.strip
  puts ""

  if option == "i" then
    puts "-" * 40
    puts "Introduce 2 números, por favor!"
    print "  Número1? "
    number1 = gets.to_i
    print "  Número2? "
    number2 = gets.to_i
  elsif option == "s" then
    puts "-" * 40
    puts "Sumar"
    puts "  #{number1} + #{number2} = #{number1 + number2}"
  elsif option == "r" then
    puts "-" * 40
    puts "Restar"
    puts "  #{number1} - #{number2} = #{number1 - number2}"
  elsif option == "m" then
    puts "-" * 40
    puts "Multiplicar"
    puts "  #{number1} * #{number2} = #{number1 * number2}"
  elsif option == "d" then
    puts "-" * 40
    puts "Dividir"
    if number2 == 0
      puts "  No se puede dividir por cero"
    else
      puts "    #{number1} / #{number2} = #{number1 / number2}"
    end
  elsif option == "x" then
    puts "Bye, bye!"
    exit 0
  else
    puts "(No entiendo!)"
  end

  puts ""
  print "(Pulsa enter para continuar)"
  gets
end
