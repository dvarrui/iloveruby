#!/usr/bin/env ruby 

class InstTest
  def set_foo(n)
    @foo = n
  end

  def set_bar(n)
    @bar = n
  end

  def info
    puts "#{self} foo=#{@foo} bar=#{@bar}"
  end
end

i = InstTest.new
i.info

puts " defined? " + defined? i

i.set_foo(2)
i.info

i.set_bar(4)
i.info

