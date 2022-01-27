#!/usr/bin/env ruby
# Learn more URL: https://www.ruby2d.com/learn/sprites/
require 'ruby2d'

coin = Sprite.new(
  'images/coin.png',
  clip_width: 84,
  time: 300,
  loop: true
)

coin.play

show # Show a window
