#!/usr/bin/env ruby

def multiplication_table(n)
  1.upto(n) do |x|
    1.upto(x-1) {|y| print "    "}
    x.upto(n)   {|y| print " %3d" % (x*y)}
    puts
  end
end
 
multiplication_table 10

