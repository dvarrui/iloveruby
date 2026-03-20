#!/usr/bin/env ruby

ZERO    = -> p { -> x {           x      }}
ONE     = -> p { -> x {         p[x]     }}
TWO     = -> p { -> x {       p[p[x]]    }}
THREE   = -> p { -> x {     p[p[p[x]]]   }}
FOUR    = -> p { -> x {   p[p[p[p[x]]]]  }}
FIVE    = -> p { -> x { p[p[p[p[p[x]]]]] }}
FIFTEEN = -> p { -> x { p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]] }}

def to_integer(proc)
  proc[ -> n {n + 1}][0]
end

_TRUE  = -> x { -> y { x }}
_FALSE = -> x { -> y { y }}
IF     = -> b { b }

def to_boolean(proc)
  IF[proc][true][false]
end


(to_integer(ONE)..to_integer(FIFTEEN)).map do |n|
  IF[(n % to_integer(FIFTEEN)).zero?][
    puts 'FizzBuzz'
  ][IF[(n % to_integer(THREE)).zero?][
    puts 'Fizz'
  ][IF[(n % to_integer(FIVE)).zero?][
    puts 'Buzz'
  ][
    puts n.to_s
  ]]]
end
