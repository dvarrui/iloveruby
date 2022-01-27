#!/usr/bin/ruby

def test(&block)
   block.call
end

puts "SCRIPTNAME : #{$0}"
test { puts "Hello World!"}
