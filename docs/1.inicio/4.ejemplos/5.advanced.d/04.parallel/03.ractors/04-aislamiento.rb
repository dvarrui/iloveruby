#!/usr/bin/env ruby
$VERBOSE=nil

class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end
end
obiwan = Person.new("Obiwan", 55)

ractors = []
list = [
  [ "ractor 1", :symbol ],
  [ "ractor 2", [1,2,3] ],
  [ "ractor 3", obiwan ]
]

list.each do |name, data|
  ractor = Ractor.new name, data do |name, data|
    puts "[#{name}] #{data.class} | #{data} | id:#{data.object_id}"
  end
  ractors << ractor
end

list.each do |name, data|
  puts "[  main  ] #{data.class} | #{data} | id:#{data.object_id}"
end

ractors.each { _1.take }
