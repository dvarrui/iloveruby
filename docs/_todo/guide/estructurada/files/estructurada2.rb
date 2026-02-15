#!/usr/bin/env ruby

## Estructura condicional

print "Select lang (en, es): "
lang = gets.chomp

if lang == 'en'
  puts "Hello!"
elsif lang == 'es'
  puts "¡Hola!"
else
  puts "Sorry, I don't speak #{lang}"
end
