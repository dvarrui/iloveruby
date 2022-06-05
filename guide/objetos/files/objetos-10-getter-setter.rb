#!/usr/bin/env ruby

class Person

  def name
    return @name
  end

  def name=(value)
    @name = value
  end

end

jedi = Person.new
jedi.name = 'Obi-wan'

puts jedi.name 
