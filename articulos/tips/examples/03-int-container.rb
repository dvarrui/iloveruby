#!/usr/bin/env ruby

class IntContainer
   def initialize(value, origref=nil)
     @value = value
     @origref = origref
   end

   def +@
     case @origref
     when nil
       val = @value
       puts "[ DEBUG ] init.+@()\t\t| return new Init(value: #{val}, self)"
       IntContainer.new(val, self)
     else
       @origref.value += 1
       puts "[ DEBUG ] init.+@()\t\t| value=#{@origref.value}, return origref=#{@origref.object_id}"
       @origref
     end
   end

   def -@
     case @origref
     when nil
       val = @value
       puts "[ DEBUG ] init.-@()\t\t| return new Init(value: #{val}, self)"
       IntContainer.new(val, self)
     else
       @origref.value -= 1
       puts "[ DEBUG ] init.-@()\t\t| value=#{@origref.value}, return origref=#{@origref.object_id}"
       @origref
     end
   end

   attr_accessor :value

   def method_missing(meth, ...)
     puts "[ DEBUG ] @value.send(#{meth}, ...)"
     IntContainer.new(@value.send(meth, ...))
   end

   def inspect(...) = @value.inspect(...)
   def to_s(...) = @value.to_s(...)
end

int = IntContainer.new(5)
puts "[ INFO  ] int -> #{int}\t\t| object_id=#{int.object_id}, value=#{int.value}"
puts "[ EXEC  ] (int + 10)"
puts "[ INFO  ] (int + 10) -> #{int + 10}"
puts "[ INFO  ] int -> #{int}\t\t| object_id=#{int.object_id}, value=#{int.value}"
puts ""
puts "[ EXEC  ] ++int"
++int
puts "[ INFO  ] int -> #{int}\t\t| object_id=#{int.object_id}, value=#{int.value}"
puts ""
puts "[ EXEC  ] --int"
--int
puts "[ INFO  ] int -> #{int}\t\t| object_id=#{int.object_id}, value=#{int.value}"
puts ""
puts "[ EXEC  ] ----int"
----int
puts "[ INFO  ] int -> #{int}\t\t| object_id=#{int.object_id}, value=#{int.value}"
