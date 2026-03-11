#!/usr/bin/env ruby

require_relative 'lib/game'

# Define game rules

rules = []

combi = Combination.new(6,8,2)
rules << Rule.new( combination: combi, included: 1, in_position: 1)

combi = Combination.new(6,1,4)
rules << Rule.new( combination: combi, included: 1, in_position: 0)

combi = Combination.new(2,0,6)
rules << Rule.new( combination: combi, included: 2, in_position: 0)

combi = Combination.new(7,3,8)
rules << Rule.new( combination: combi, included: 0, in_position: 0)

combi = Combination.new(7,8,0)
rules << Rule.new( combination: combi, included: 1, in_position: 0)

# [-] Respuesta: [0, 4, 2]

Game.play_with rules
