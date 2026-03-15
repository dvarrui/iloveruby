#!/usr/bin/env ruby

require_relative 'lib/04-include_name_of.rb'

obiwan = { name: 'Obiwan', type: 'jedi' }
maul   = { name: 'Maul',   type: 'sith' }

show(name(obiwan))
show name of maul
