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
    @names << other.name if other.class == Person
    if other.class == Group
      @names << other.names
      @names.flatten!
    end
    self
  end
end

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "Person:  name => #{name}"
  end

  def +(other)
    g = Group.new
    g.names << name
    g.names << other.name
    g
  end
end
