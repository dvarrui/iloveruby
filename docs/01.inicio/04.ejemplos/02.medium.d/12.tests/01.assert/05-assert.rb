#!/usr/bin/env ruby

class AssertionError < RuntimeError
end

def assert &block
    raise AssertionError unless yield
end

i = 1
assert { i >= 0 }
assert { 5 == 12 }
