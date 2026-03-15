#!/usr/bin/env ruby

require_relative "lib-03-parafun"

obiwan = Character.new( name: 'Obiwan', type: 'jedi')
maul = Character.new(name: 'Maul', type: 'sith')

obiwan.name.show
obiwan.type.show

maul.name.show
maul.type.show
