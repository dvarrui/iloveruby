#!/usr/bin/env ruby

require_relative 'lib/animal-05'
require_relative 'lib/perro-05'

a = Animal.new('Tom')
p = Perro.new('Jerry', 'Bulldog')

a.show
pp a
p.show
pp p
