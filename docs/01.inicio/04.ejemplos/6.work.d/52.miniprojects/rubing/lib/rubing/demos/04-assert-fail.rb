def assert &block
  raise "AssertionError" unless yield
end

a = 3
b = 4
puts a + b

assert{a + b != 7}
