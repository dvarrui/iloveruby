#!/usr/bin/env ruby

def assert(var, value)
  unless var == value
    raise "[Assert FAIL] var=#{var} <> value=#{value}"
  end
end

a = 2
b = 3
c = a * b

assert a, 2
assert b, 3
assert c, 5

