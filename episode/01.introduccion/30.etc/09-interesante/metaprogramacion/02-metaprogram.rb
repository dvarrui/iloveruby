#!/usr/bin/env ruby

class Person
  def getter(var)
    define_singleton_method(var) do
      instance_variable_get("@#{var}")
    end
  end

  def initialize(name)
    @name = name
    getter('name')
  end

end

quigon = Person.new("Qui-gon Jinn")

puts '='*60
puts "Object             : #{quigon}"
puts "Instance variables : #{quigon.instance_variables}"
puts "Method with name   : #{quigon.public_methods.grep(/name/)}"
puts "Object#name        : #{quigon.name}"
puts '='*60
