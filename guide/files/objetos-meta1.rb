#!/usr/bin/env ruby

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

obiwan = Person.new("Luke")
obiwan.name = "Obi-wan"

puts obiwan.name
