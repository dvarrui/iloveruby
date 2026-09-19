#!/usr/bin/env ruby

def echo(*args)
  puts args.join(' ')
end

echo "[Example] #{$0}"
echo "Hola", 42
echo "qué", "tal?"
exit 0
