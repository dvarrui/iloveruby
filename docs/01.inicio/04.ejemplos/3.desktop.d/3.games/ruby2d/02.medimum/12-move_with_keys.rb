#!/usr/bin/env ruby
# Learn more URL: https://www.ruby2d.com/learn/2d-basics/
require 'ruby2d'

# Define a square shape.
@square = Square.new(x: 10, y: 20, size: 25, color: 'blue')

# Define the initial speed (and direction).
@x_speed = 0
@y_speed = 0

# Define what happens when a specific key is pressed.
# Each keypress influences on the  movement along the x and y axis.
on :key_down do |event|
  if event.key == 'j'
    @x_speed = -2
    @y_speed = 0
  elsif event.key == 'l'
    @x_speed = 2
    @y_speed = 0
  elsif event.key == 'i'
    @x_speed = 0
    @y_speed = -2
  elsif event.key == 'k'
    @x_speed = 0
    @y_speed = 2
  end
end

update do
  @square.x += @x_speed
  @square.y += @y_speed
end

show
