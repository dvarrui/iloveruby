#!/usr/bin/env ruby

require_relative "lib-02-parafun"

obiwan = Character.new( name: 'Obiwan', type: 'jedi')
maul = Character.new(name: 'Maul', type: 'sith')

obiwan.show
maul.show
