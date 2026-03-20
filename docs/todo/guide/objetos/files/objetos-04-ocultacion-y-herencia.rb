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

class Jedi < Person
  def invoke_private_method_with(text)
    shuffle(text)
  end
end

obiwan = Jedi.new("Obi-wan")
puts obiwan.name

begin
  puts obiwan.inkove_private_method_with('Kenobi')
rescue
  puts "Can't invoke private method!"
end
