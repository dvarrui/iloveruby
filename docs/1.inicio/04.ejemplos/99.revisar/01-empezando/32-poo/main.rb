#!/usr/bin/env ruby

require_relative 'animal'
require_relative 'perro'

a = Animal.new('Tom')
p = Perro.new('Jerry', 'Bulldog')

a.show
p.show
