#!/usr/bin/env ruby

require_relative "lib/life-game"

LifeGame.play(ARGV || 'example/demo.txt')
