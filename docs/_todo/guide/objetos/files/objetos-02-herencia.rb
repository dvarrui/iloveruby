#!/usr/bin/env ruby

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Jedi < Person
  def greet
    "I'm Jedi, #{@name}"
  end
end

class Sith < Person
  def greet
    "I'm Lord #{@name}"
  end
end

obiwan = Jedi.new("Obi-wan")
vader = Sith.new("Vader")

puts obiwan.greet
puts vader.greet
