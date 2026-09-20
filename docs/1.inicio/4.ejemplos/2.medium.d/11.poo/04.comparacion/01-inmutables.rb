#!/usr/bin/env ruby

=begin
En Ruby todo son objetos (o caso todo) y algunos tipos/clases de objetos son inmutables o de valor fijo.
Esto quiere decir que el cambio de la instancia genera otra instancia diferente.
Veamos ejemplo de datos inmutables:
=end

require_relative 'lib/utils'

now_cames(:integer, <<-TEXT
a = 3
b = 3

puts a.class
puts a + b
puts a == b
puts a.object_id == b.object_id
puts a.object_id
puts a.succ
puts a.succ.object_id
TEXT
)

=begin
Objetos inmutables son los Integer, Float, Rational, Symbol
=end

now_cames(:string, <<-TEXT
a = "obiwan"
b = "obiwan"

puts a.class
puts a + b
puts a == b
puts a === b
puts a.object_id == b.object_id
puts a.object_id
TEXT
)
