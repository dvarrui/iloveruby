#!/usr/bin/env ruby

require "debug"
require_relative "screen"
require_relative "scene"

trap('SIGINT') { puts "Bye!"; exit! }

@screen = Screen.new
@scene = Scene.new
@scene.screen = @screen
@scene.init

@screen.clear
timestamp = Time.now
loop do
  delta = Time.new - timestamp
  timestamp = Time.new

  @scene.update(delta)
  @scene.render
  @screen.move(2, 2)

  wait = 0.2
  sleep(wait - delta) if delta < wait
end
