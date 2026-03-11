#!/usr/bin/env ruby

system("Rscript r/20-create-png.r")

require 'ruby2d'

Image.new( 'images/private.20-image.png' )
show # Show a window
