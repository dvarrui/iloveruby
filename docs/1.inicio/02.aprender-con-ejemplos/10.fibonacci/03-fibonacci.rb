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
puts "==> number=#{number}"

# 2. Calcular lo N primeros elementos de la sucesión de Fibonacci.
fibonacci = Enumerator.new do |yielder|
  a, b = 0, 1
  loop do
    yielder << a
    a, b = b, a + b
  end
end

# 3. Mostrar por pantalla
fibonacci.take(number).each_with_index do |fib, index|
  puts "fib(#{index})=#{fib}"
end

# 4. Escribirlos en un fichero llamado `fibonacci.txt`.
