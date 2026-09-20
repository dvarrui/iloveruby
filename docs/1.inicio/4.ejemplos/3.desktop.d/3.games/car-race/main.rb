#!/usr/bin/env ruby

require_relative "game"
require_relative "level"

trap('SIGINT') { puts "Bye!"; exit! }

level = Level.new

game = Game.new(level)
game.run
