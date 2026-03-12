#!/usr/bin/env ruby

class Fruit
  def kind=(k)
    @kind = k
  end

  def kind
    @kind
  end

  def to_s
    "Una fruta de la variedad " + @kind
  end
end

f = Fruit.new
f.kind = "banana"
puts "(1) Veamos el tipo de la fruta: kind=" + f.kind
puts "(2) Información del objeto: #{f}"
p f

