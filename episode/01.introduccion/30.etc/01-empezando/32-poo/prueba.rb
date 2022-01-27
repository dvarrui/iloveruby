#!/usr/bin/env ruby

class Prueba
  puts "01"

  def initialize
    puts "02"
  end

  def verb
    puts "03"
  end
end

puts "04"

a = Prueba.new
a.verb
