#!/usr/bin/env ruby

# Static method 
# Implement a static method in ruby class using class var

class Foo
   @@x = 0

   def self.count
     @@x += 1
     @@x
   end
end

puts Foo.count
puts Foo.count
puts Foo.count


# Avoid using class variables. 
# They don’t quite work the way you think they do. 
# They still have their place, but it’s exceedingly rare.
#
# Prefer instance variables, remembering that classes are instances, too.

