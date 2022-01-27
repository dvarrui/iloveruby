#!/usr/bin/env ruby
# Learn more URL: https://www.ruby2d.com/learn/sprites/

require 'ruby2d'

hero = Sprite.new(
  'images/hero.png',
  width: 78,
  height: 99,
  clip_width: 78,
  time: 250,
  animations: {
    walk: 1..2,
    climb: 3..4,
    cheer: 5..6
  }
)

on :key_down do |event|
  case event.key
    when 'left'
      hero.play animation: :walk, loop: true, flip: :horizontal
    when 'right'
      hero.play animation: :walk, loop: true
    when 'up'
      hero.play animation: :climb, loop: true
    when 'down'
      hero.play animation: :climb, loop: true, flip: :vertical
    when 'c'
      hero.play animation: :cheer
  end
end

show # Show a window
