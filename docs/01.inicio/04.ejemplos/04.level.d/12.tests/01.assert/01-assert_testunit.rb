#!/usr/bin/env ruby
# Fuente: https://www.iteramos.com/pregunta/96723/como-imprimir-los-nombres-de-las-pruebas-unitarias-de-ruby

require 'test/unit' 

class TC_MyTest < Test::Unit::TestCase 
  def test_something 
    assert(true) 

    a = 2
    b = 3
    c = a * b
    assert(c == 9)
  end 
end
