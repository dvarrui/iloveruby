#!/usr/bin/env ruby
# Jesús Gómez @jgomo3
# Is there a way to define a method as "final"?
# "final" meaning that the method can't be overwritten by a child class.

a = "Hello"
begin
  puts a.happy
rescue
  puts "[INFO] happy not defined yet!"
end

class String
  def happy
    self + "!"
  end
end

puts a.happy
a.freeze

class String
  def happy
    self + "[Redefined]"
  end
end

# So, freeze can't make class static

puts a.happy
