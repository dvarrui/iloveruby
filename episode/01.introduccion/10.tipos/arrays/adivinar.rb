#!/usr/bin/ruby
# Salvar como guess.rb
words = ['ruby', 'java', 'c++']
secret = words[rand(3)]
print "adivina un lenguaje de programación? "

while guess = STDIN.gets
  guess.chop!
  if guess == secret
      print "¡Ganas!\n"
      break
  else 
      if guess > secret
          print "La palabra es menor que #{guess}\n"
      else
          print "La palabra es mayor que #{guess}\n"
      end
  end
  print "adivina? "
end
print "La palabra era ", secret, ".\n"

