#!/usr/bin/env ruby

require 'ruby2d'

Image.new(
  'images/teuton.png',
  x: 400, y: 200,
  width: 100, height: 100,
  color: [1.0, 1.0, 1.0, 1.0],
  z: 10
)

show # Show a window
