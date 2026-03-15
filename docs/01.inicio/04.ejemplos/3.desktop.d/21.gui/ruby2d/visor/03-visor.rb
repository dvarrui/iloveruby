#!/usr/bin/env ruby

require 'ruby2d'

def configure_window(version:)
  set title: "visor #{version} (ruby2d)"
  set background: 'blue'
end

def show_image(filename)
  dirbase = File.join(File.dirname(__FILE__), '..', 'images')
  filepath = File.join(dirbase, filename)
  image = Image.new(filepath, x: 50, y: 50)
  return image
end

def process_input
  on :key_down do |event|
    close if event.key == 'q'
  end
end

# Main loop
configure_window(version: 'v03')
show_image('teuton.png')
process_input
show

