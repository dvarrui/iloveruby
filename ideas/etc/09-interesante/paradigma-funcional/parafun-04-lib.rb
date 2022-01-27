#!/usr/bin/env ruby
require 'pry'

module CharacterFunction
  def show(value)
    puts "My name is #{value}."
  end

  def name(value=nil)
    return 'No name' if value.nil?
    return value if value.class == String
    return value[:name] if value.class == Hash
  end

  def of(value)
    value
  end
end

include CharacterFunction
