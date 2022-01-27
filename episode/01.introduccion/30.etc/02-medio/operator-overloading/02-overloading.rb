#!/usr/bin/env ruby

require_relative '02-overloading-lib'

obiwan = Person.new("Obiwan")
yoda = Person.new("Yoda")
group1 = obiwan + yoda

vader = Person.new("Darth Vader")
maul = Person.new("Darth Maul")
group2 = vader + maul

puts obiwan
puts yoda
puts group1
puts (group1 + group2).to_s
