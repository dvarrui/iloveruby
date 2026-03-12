#!/usr/bin/env ruby

def echo(*args)
  puts args.join(' ')
end

echo "[Example] #{$0}"
echo "Hola", 42
echo "qué", "tal?"

puts $0
puts $1
puts $2
puts $?
puts $!
puts $@

