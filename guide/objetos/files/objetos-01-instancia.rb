#!/usr/bin/env ruby

class Person
  def initialize(name)
    @name = name
  end

  def name
    @name
  end

  def to_s
    "Hi! I'm a Person and my name is #{@name}"
  end
end

obiwan = Person.new("Obi-wan")

puts obiwan.name
puts obiwan
