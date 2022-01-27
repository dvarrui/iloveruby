#!/usr/bin/env ruby
# Learn more URL: https://www.ruby2d.com/learn/text/
require 'ruby2d'

Text.new(
  'Hello World!',
  x: 150, y: 170,
  #font: 'vera.ttf',
  size: 40,
  color: 'blue',
  rotate: 90,
  z: 10
)

show # Show a window
