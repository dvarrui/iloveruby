#!/usr/bin/env ruby

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

obiwan = { name: 'Obiwan', type: 'jedi' }
maul   = { name: 'Maul',   type: 'sith' }

include CharacterFunction

show(name(obiwan))
show name of maul
