#!/usr/bin/env ruby

def assign(*)
  puts "assign"
end

def variable(*)
  puts "variable"
end

def a
  puts "a"
end

assign variable a

# => a
# => variable
# => assign

