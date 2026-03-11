#!/usr/bin/env ruby

require 'ruby2d'

set title: "Quads"

r = Rectangle.new(
  x: 250, y: 280,
  width: 200, height: 150,
  color: 'olive',
  z: 10
)

q = Quad.new(
  x1: 275, y1: 175,
  x2: 375, y2: 225,
  x3: 300, y3: 350,
  x4: 250, y4: 250,
  color: 'aqua',
  z: 20
)

show
