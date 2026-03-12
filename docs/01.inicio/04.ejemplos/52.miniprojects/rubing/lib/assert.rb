def assert &block
  raise "AssertionError" unless yield
end

