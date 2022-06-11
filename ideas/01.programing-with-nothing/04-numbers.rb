#!/usr/bin/env ruby

def zero(proc, x)
  x
end

def one(proc, x)
  proc[x]
end

def two(proc, x)
  proc[proc[x]]
end

def three(proc, x)
  proc[proc[proc[x]]]
end

p = lambda { |x| x + 1 }
puts "Using def   + lambda : three(p,2) => #{three(p, 2)}"

ZERO  = -> p { -> x {       x    }}
ONE   = -> p { -> x {     p[x]   }}
TWO   = -> p { -> x {   p[p[x]]  }}
THREE = -> p { -> x { p[p[p[x]]] }}

puts "Using const + lambda : THREE.(p).(3) => #{THREE.(p).(3)}"

