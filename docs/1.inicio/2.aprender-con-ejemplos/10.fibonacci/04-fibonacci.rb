#!/usr/bin/env ruby

def show_usage
  puts "Usage: #{$0} NUMBER"
  exit 1
end

if ARGV.length != 1
  show_usage
end

# 1. Pedir un número al usuario.
number = ARGV[0].to_i
puts "==> Calcular los #{number} primeros números de Fibonacci"

# 2. Calcular lo N primeros elementos de la sucesión de Fibonacci.
puts "==> Enfoque con memoización"

def fibonacci(n, cache = {})
  return n if n <= 1
  cache[n] ||= fibonacci(n - 1, cache) + fibonacci(n - 2, cache)
end

data = []
number -= 1
(0..number).each { |index| data << fibonacci(index) }

# 3. Mostrar por pantalla
data.each_with_index do |fib, index|
  puts "fib(#{index})=#{fib}"
end

# 4. Escribirlos en un fichero llamado `fibonacci.txt`.

