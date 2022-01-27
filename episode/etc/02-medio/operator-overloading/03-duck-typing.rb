#!/usr/bin/env ruby

require 'rainbow'
require_relative '03-duck-typing-lib'

def sum(a,b)
  print "Sum(#{Rainbow(a).green.bright},"
  print "#{Rainbow(b).green.bright}) => "
  print "#{Rainbow(a+b).yellow.bright}\n"
end

obiwan = Person.new("Obiwan")
yoda = Person.new("Yoda")

sum(1, 3)
sum(5.2, 2.3)
sum("Hola", "Mundo!")
sum(obiwan, yoda)
