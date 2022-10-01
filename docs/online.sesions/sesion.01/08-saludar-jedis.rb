#!/usr/bin/env ruby

print "Escribe tu nombre: "
name = gets.chomp

case name
when 'Darth'..'DarthZ'
  puts "UUUUUUU"
when 'Jedi'..'JediZ'
  puts "Hola #{name}!"
else
  puts "No te conozco #{name}!"
end


