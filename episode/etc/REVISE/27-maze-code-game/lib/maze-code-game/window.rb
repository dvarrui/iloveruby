require 'ruby2d'
require_relative 'application'
require_relative 'player'

set title: Application::NAME

hero = Player.new

on :key_down do |event|
  case event.key
    when 'left'
      hero.left
    when 'right'
      hero.right
    when 'up'
      hero.up
    when 'down'
      hero.down
    when 'c'
      hero.c
  end
end
show
