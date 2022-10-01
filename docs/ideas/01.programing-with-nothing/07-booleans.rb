#!/usr/bin/env ruby

require 'colorize'

def debug(sentence, b)
  puts sentence.white
  b.eval sentence
end

#def true(x, y)
#  x
#end

#def false(x, y)
#  y
#end

_TRUE  = -> x { -> y { x }}
_FALSE = -> x { -> y { y }}

debug "puts _TRUE.(42).('hola')", binding
debug "puts _FALSE.(42).('hola')", binding

def to_boolean(proc)
  proc[true][false]
end

debug "puts to_boolean(_TRUE)", binding
debug "puts to_boolean(_FALSE)", binding

