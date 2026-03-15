#!/usr/bin/env ruby

# https://www.matematicasonline.es/cuarto-eso/tecnicas_de_recuento/combinatoria_archivos/factorial.htm

def factorial(number)
  n = number.to_i
  return '(Debe ser positivo)' if n < 0
  return 1 if n <= 1

  n * factorial(n-1)
end

def mostrar_factorial_de(number)
  n = number.to_i
  puts "#{n}! = #{factorial(n)}"
end

numbers = [0, 1, 3, -1, 4]
numbers.each { |number| mostrar_factorial_de number }
