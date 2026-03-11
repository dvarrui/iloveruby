#!/usr/bin/env ruby

require "colorize"

class World
  def initialize(screen)
    @screen = screen
    @road = Array.new(@screen.height, @screen.width/2 - 5)
  end

  def update
    new_road = @road.last + 1 - rand(3)
    if new_road < 10 || new_road > @screen.width - 10
      new_road = @road.last
    end
    @road.push(new_road)
    @road.shift
  end

  def render
    @road.reverse.each_with_index do |x, y|
      text = "*".on_green + "             " + "*".on_green
      @screen.show x, y, text
    end
  end
end
