#!/usr/bin/env ruby

require 'ruby2d'

Line.new(
  x1: 125, y1: 100,
  x2: 350, y2: 400,
  width: 25,
  color: 'lime',
  z: 20
)

Circle.new(
  x: 200, y: 175,
  radius: 150,
  sectors: 32,
  color: 'fuchsia',
  z: 10
)

show # Show a window
