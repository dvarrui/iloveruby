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

(to_integer(ONE)..to_integer(FIFTEEN)).map do |n|
  if (n % to_integer(FIFTEEN)).zero?
    puts 'FizzBuzz'
  elsif (n % to_integer(THREE)).zero?
    puts 'Fizz'
  elsif (n % to_integer(FIVE)).zero?
    puts 'Buzz'
  else
    puts n.to_s
  end
end
