#!/usr/bin/env ruby

def assert(args)
  var = args[:var]
  value = args[:value]
  line = args[:line]

  unless var == value
    raise "[Assert FAIL] line #{line}: var=#{var} <> value=#{value}"
  end
end

a = 2
b = 3
c = a * b

assert var: a, value: 2, line: __LINE__
assert var: b, value: 3, line: __LINE__
assert var: c, value: 5, line: __LINE__

