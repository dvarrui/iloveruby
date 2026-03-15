#!/usr/bin/env ruby
require 'pry'

module CharacterFunction
  def show(value)
    puts value
  end

  def name(value=nil)
    n =  'No name' if value.nil?
    n = value if value.class == String
    n = value[:name] if value.class == Hash
    "My name is #{n}"
  end

  def of(value)
    value
  end

  def and_then(value)
    value
  end

  def type(value=nil)
    t = 'No type' if value.nil?
    t = value if value.class == String
    t = value[:type] if value.class == Hash
    "I'm a #{t}"
  end

  def song(value=nil)
    s = value if value.class == String
    s = name(value) if value.class == Hash
    "La la lalaaaaaa oh #{s}!!!!"
  end
end

include CharacterFunction
