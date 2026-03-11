#!/usr/bin/env ruby


class A
  def m1
    puts "A: m1"
  end

  def m2
    puts "A: m2"
  end
end

a = A.new
a.m1
a.m2

class A
  def m1
    puts "A: m1 was redefined"
  end
end

a.m1

