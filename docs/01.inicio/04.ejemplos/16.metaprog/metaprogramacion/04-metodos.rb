#!/usr/bin/env ruby 

def a(x,y)
  x + y
end

class MiClase
  attr_reader :res

  def initialize(funcion, param1, param2)
    @fun = funcion
    @res = @fun.call(param1, param2)
  end
end

c = MiClase.new(method(:a), 4, 3)
puts c.res
