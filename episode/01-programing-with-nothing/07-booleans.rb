#!/usr/bin/env ruby

#def true(x, y)
#  x
#end

#def false(x, y)
#  y
#end

_TRUE  = -> x { -> y { x }}
_FALSE = -> x { -> y { y }}

puts _TRUE.(42).('hola')
puts _FALSE.(42).('hola')

def to_boolean(proc)
  proc[true][false]
end

puts to_boolean(_TRUE)
puts to_boolean(_FALSE)
