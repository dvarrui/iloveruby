#!/usr/bin/env ruby
require 'pry'

module CharacterFunction
  def show(value)
    puts value
  end
end

include CharacterFunction

obiwan = 'Obiwan'
maul   = 'Maul'

show(obiwan)
show maul
