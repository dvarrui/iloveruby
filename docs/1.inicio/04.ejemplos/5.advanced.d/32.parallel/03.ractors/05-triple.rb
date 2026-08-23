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

ractors = []
list.each do |name, data|
  ractor = Ractor.new name do |name|
    puts "[#{name}] Waiting..."
    msg = Ractor.receive
    puts "[#{name}] Received: #{data.class} | #{data} | id:#{data.object_id}"
    msg
  end
  ractors << [name, data, ractor]
end

ractors.each do |item|
  # name = item[0]
  data = item[1]
  ractor = item[2]
  puts "[  main  ] #{data.class} | #{data} | id:#{data.object_id}"
  ractor.send(data)
  puts "[  main  ] Received: #{ractor.take}"
end
