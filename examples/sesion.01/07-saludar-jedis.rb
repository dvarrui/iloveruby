#!/usr/bin/env ruby

print "Escribe tu nombre: "
name = gets.chomp

if name.start_with? "Darth"
  puts "UUUUUUU"
elsif name.start_with? "Jedi"
  puts "Hola #{name}!"
else
  puts "No te conozco #{name}!"
end


