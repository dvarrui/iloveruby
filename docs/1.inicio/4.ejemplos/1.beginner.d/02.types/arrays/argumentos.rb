#!/usr/bin/env ruby

class Argumentos
 
  def metodo(*n)
    puts "[-] nº args:#{n.size} => #{n.join(', ')}."
  end

end

p = Argumentos.new
p.metodo "yoda"
p.metodo "obiwan","kenobi"
p.metodo "Lord", "Darth", "Vader"

