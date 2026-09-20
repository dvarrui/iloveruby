#!/usr/bin/env ruby

def factorial1(n)
  # Bucle imperativo
  value = 1 
  while(n > 1) do
    value *= n
    n -= 1
  end
  value
end

def factorial2(n)
  # Recursivo
  return 1 if n < 2
  n * factorial1(n -1 )
end

# Estilo funcional
def factorial3(n) = (1..n).reduce(1, :*)

puts "factorial1(5) = #{factorial1 5}"
puts "factorial2(5) = #{factorial2 5}"
puts "factorial3(5) = #{factorial3 5}"
