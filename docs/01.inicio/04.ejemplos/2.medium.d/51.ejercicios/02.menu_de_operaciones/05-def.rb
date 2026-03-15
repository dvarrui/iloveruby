#!/usr/bin/env ruby

def mostrar_menu(a, b)
  # Mostrar el menú
  puts "=" * 40
  puts "Menú"
  puts "  i  Introducir números"
  puts "     number1 = #{a}, number2 = #{b}"
  puts "  s  Sumar"
  puts "  r  Restar"
  puts "  m  Multiplicar"
  puts "  d  Dividir"
  puts "  x  Salir"
  puts ""
end

def sumar(a, b)
  puts "-" * 40
  puts "Sumar"
  puts "  #{a} + #{b} = #{a + b}"
end

def restar(a, b)
  puts "-" * 40
  puts "Restar"
  puts "  #{a} - #{b} = #{a - b}"
end

def multiplicar(a, b)
  puts "-" * 40
  puts "Multiplicar"
  puts "  #{a} * #{b} = #{a * b}"
end

def dividir(a, b)
  puts "-" * 40
  puts "Dividir"
  if b == 0
    puts "  No se puede dividir por cero"
  else
    puts "  #{a} / #{b} = #{a / b}"
  end
end

# Inicializar variables
number1=0
number2=0

loop do
  mostrar_menu(number1, number2)
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
    sumar(number1, number2)
  elsif option == "r" then
    restar(number1, number2)
  elsif option == "m" then
    multiplicar(number1, number2)
  elsif option == "d" then
    dividir(number1, number2)
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
