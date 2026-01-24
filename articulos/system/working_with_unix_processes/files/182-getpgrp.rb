#!/usr/bin/env ruby

puts "\nParent:"
puts Process.pid
puts Process.getpgrp

fork {
  puts "\nChild:"
  puts Process.pid
  puts Process.getpgrp
}
