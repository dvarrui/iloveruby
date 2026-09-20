#!/usr/bin/env ruby
$VERBOSE=nil

number = ARGV.first.to_i

# Pasamos la variable 'number' como argumento al bloque del Ractor
ractor = Ractor.new(number) do |n|
  "Hola Mundo!\n" * n
end

puts ractor.take
