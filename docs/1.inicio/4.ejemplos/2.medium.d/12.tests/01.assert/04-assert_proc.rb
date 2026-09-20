#!/usr/bin/env ruby

def assert(&proc)
  ret = proc.call

  unless ret
    raise "[Assert FAIL] proc=#{proc.to_s}"
  end
end

a = 2
b = 3
c = a * b

assert { a == 2 }
assert { b == 3 }
assert { c == 5 }

