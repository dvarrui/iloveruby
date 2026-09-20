#!/usr/bin/env ruby

require 'ruby2d'
VERSION = 'v02'

set title: "visor #{VERSION} (ruby2d)"
set background: 'blue'

filepath = File.join(File.dirname(__FILE__), '..', 'images', 'teuton.png')
image = Image.new(filepath, x: 50, y: 50)

show # Show a window
