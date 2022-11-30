#!/usr/bin/env ruby

class IntContainer
   def initialize(value, origref=nil)
     @value = value
     @origref = origref
   end

   def +@
     puts "[DEBUG ] calling: +@"
     case @origref
     when nil
       IntContainer.new(+@value, self)
     else
       @origref.value += 1
       @origref
     end
   end

   def -@
     puts "[DEBUG ] calling: -@"
     case @origref
     when nil
       IntContainer.new(-@value, self)
     else
       @origref.value -= 1
       @origref
     end
   end

   attr_accessor :value

   def method_missing(meth, ...)
     puts "[DEBUG ] calling: #{meth}"
     IntContainer.new(@value.send(meth, ...))
   end

   def inspect(...) = @value.inspect(...)
   def to_s(...) = @value.to_s(...)
end

int = IntContainer.new(5)
puts "[INFO  ] int -> #{int}"
puts ""
puts "[EXEC  ] int + 10"
puts "[INFO  ] int + 10 -> #{int + 10}"
puts "[INFO  ] int -> #{int}"
puts ""
puts "[EXEC  ] ++int"
++int
puts "[INFO  ] int -> #{int}"
puts ""
puts "[EXEC  ] --int"
--int
puts "[INFO  ] int -> #{int}"
