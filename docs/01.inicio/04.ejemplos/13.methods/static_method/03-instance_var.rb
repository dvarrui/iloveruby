#!/usr/bin/env ruby

# Static method 
# Implement a static method in ruby class with instance vars
# Remembering that classes are instances, too.

class Foo
  def self.count
    @count ||= 0
    @count += 1
  end
end

puts Foo.count
puts Foo.count
puts Foo.count

