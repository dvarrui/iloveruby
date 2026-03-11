#!/usr/bin/env ruby

def si(&block)
  result = block.call
  $SI =
  if result
    $SI = true
  else
    $SI = false
  end
  $SI
end

def entonces(&block)
  if $SI == true
    block.call
    $SI = nil
  end
end

number = 10
si { number > 3 }
entonces { puts "Number > 3" }

si { number ==  4 }
entonces { puts "Number == 4" }
