#!/usr/bin/env ruby

class Robot
  puts '01'

  def initialize
    puts '04'
  end

  def verb
    puts '05'
  end

  puts '02'
end

puts '03'

a = Robot.new
a.verb
