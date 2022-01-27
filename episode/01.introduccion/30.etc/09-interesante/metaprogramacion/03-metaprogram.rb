#!/usr/bin/env ruby

class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

quigon = Person.new("Qui-gon Jinn")

puts '='*60
puts "Object             : #{quigon}"
puts "Instance variables : #{quigon.instance_variables}"
puts "Method with name   : #{quigon.public_methods.grep(/name/)}"
puts "Object#name        : #{quigon.name}"
puts '='*60
