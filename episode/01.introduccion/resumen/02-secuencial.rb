#!/usr/bin/env ruby

# Estructura secuencial

# String
rol1 = 'father'
rol2 = 'father'

puts rol1.class
puts "Darth Vader: I'm your #{rol1}"
puts rol1 == rol2
puts rol1.object_id == rol2.object_id
puts

# Symbol
state1 = :ok
state2 = :ok

puts state1.class
puts state1
puts state1 == state2
puts state1.object_id == state2.object_id
puts

# Boolean
a = true
b = false

puts a.class
puts(a == b)
puts((a and b)) 
puts((a or b))
puts
