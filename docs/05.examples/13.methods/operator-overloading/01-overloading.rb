#!/usr/bin/env ruby

class Group
  attr_accessor :names

  def initialize
    @names = []
  end

  def to_s
    "Group : names => #{@names.to_s}"
  end

  def +(other)
    @names << other.name
  end
end

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def to_s
    "Person: name  => #{name}"
  end

  def +(other)
    g = Group.new
    g.names << name
    g.names << other.name
    g
  end
end

obiwan = Person.new("Obiwan")
yoda = Person.new("Yoda")

puts obiwan
puts yoda
puts (obiwan + yoda)
