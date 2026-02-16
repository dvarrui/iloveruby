#!/usr/bin/env ruby

class IntContainer
   def initialize(value, origref=nil)
     @value = value
     @origref = origref
   end

   def +@
     case @origref
     when nil
       IntContainer.new(@value, self)
     else
       @origref.value += 1
       @origref
     end
   end

   def -@
     case @origref
     when nil
       IntContainer.new(@value, self)
     else
       @origref.value -= 1
       @origref
     end
   end

   attr_accessor :value

   def method_missing(meth, ...)
     IntContainer.new(@value.send(meth, ...))
   end

   def inspect(...) = @value.inspect(...)
   def to_s(...) = @value.to_s(...)
end

int = IntContainer.new(5)

puts int + 10
puts (++int)
puts (--int)
