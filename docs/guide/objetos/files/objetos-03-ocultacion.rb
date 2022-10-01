#!/usr/bin/env ruby

class Person
  def initialize(name)
    @name = name
  end

  def name
    shuffle(@name)
  end

  private

  def shuffle(text)
    text.reverse
  end
end

obiwan = Person.new("Obi-wan")
puts obiwan.name

begin
  puts obiwan.shuffle('Kenobi')
rescue
  puts "Can't invoke private method!"
end
