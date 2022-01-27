#!/usr/bin/env ruby

require_relative 'parafun-13-lib'

obiwan = Character.new( name: 'Obiwan', type: 'jedi')
maul = Character.new(name: 'Maul', type: 'sith')

obiwan.name.show
obiwan.type.show

maul.name.show
maul.type.show
