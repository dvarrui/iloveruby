#!/usr/bin/env ruby

f1 = lambda { puts "I am function 1" }
puts "[INFO] lambda1 (#{f1.class})"

f1.call
f1[]
f1.===

f2 = ->() { puts "I am function 2" }
puts "\n[INFO] lambda2 (#{f2.class})"

f2.call
