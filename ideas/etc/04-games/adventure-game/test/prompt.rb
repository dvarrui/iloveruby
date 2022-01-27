#!/usr/bin/env ruby

while(true)
  print "prompt> "
  a = STDIN.gets.chop
  puts "=> " + a
  exit if a == 'quit'
end
