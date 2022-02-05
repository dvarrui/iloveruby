#!/usr/bin/env ruby

require_relative 'lib/utils'

# Estructura secuencial
# Tipos: String, Symbol, Boolean

# String
now_cames(:string, <<-TEXT
rol1 = 'father'
rol2 = 'father'

puts rol1.class
puts "Darth Vader: I'm your \#{rol1}"
puts rol1 == rol2
puts rol1.object_id == rol2.object_id
TEXT
)

rol1 = 'father'
rol2 = 'father'

puts rol1.class
puts "Darth Vader: I'm your #{rol1}"
puts rol1 == rol2
puts rol1.object_id == rol2.object_id

# Symbol
now_cames(:symbol, <<-TEXT
state1 = :ok
state2 = :ok

puts state1.class
puts state1
puts state1 == state2
puts state1.object_id == state2.object_id
TEXT
)

state1 = :ok
state2 = :ok

puts state1.class
puts state1
puts state1 == state2
puts state1.object_id == state2.object_id

# Boolean
now_cames(:bool, <<-TEXT
a = true
b = false

puts a.class
puts(a == b)
puts((a and b))
puts((a or b))
TEXT
)
a = true
b = false

puts a.class
puts(a == b)
puts((a and b))
puts((a or b))
