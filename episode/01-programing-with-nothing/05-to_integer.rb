#!/usr/bin/env ruby

ZERO  = -> p { -> x {       x    }}
ONE   = -> p { -> x {     p[x]   }}
TWO   = -> p { -> x {   p[p[x]]  }}
THREE = -> p { -> x { p[p[p[x]]] }}

def to_integer(proc)
  proc[ -> n {n + 1}][0]
end

puts to_integer(ZERO)
puts to_integer(THREE)
