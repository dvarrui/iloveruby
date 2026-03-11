#!/usr/bin/env ruby

def si(&block)
  result = block.call 
  return true if result
  false
end

number = 10
puts si { number > 3 }
puts si { number ==  4 }
