#!/usr/bin/ruby

# ri String#size
if ARGV.size.zero?
    puts "¡Disculpe! ¿Le conozco?"
elsif ARGV.size == 1
  print "¿Cuantas veces le saludo ",ARGV[0],"?\n"
else
  n = ARGV[1].to_i
  n.times do
    print "Hola ", ARGV[0], "!\n"
  end
end
