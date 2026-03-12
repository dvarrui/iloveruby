#!/usr/bin/env ruby

class Foo
  @@prog=0

  def initialize
    @@prog += 1
    @prog = @@prog
  end

  def to_s
    "I am Foo ##{@prog}"
  end
end

f1=Foo::new
f2=Foo::new
f3=Foo::new

[f1,f2,f3].each_with_index { |f| puts f }

