#!/usr/bin/env ruby

require 'ruby2d'

def configure_window(version:)
  set title: "visor #{version} (ruby2d)"
  set background: 'blue'
end

def show_image(filename)
  text = Text.new("Image: #{filename}", x: 50, y: 50, size: 40, color: 'white', z: 10)
  dirbase = File.join(File.dirname(__FILE__), '..', 'images')
  filepath = File.join(dirbase, filename)
  image = Image.new(filepath, x: 50, y: 100)
  return image
end

def process_input
  on :key_down do |event|
    if ['q', 'escape', 'e'].include? event.key
      close
    else
      puts event.key
    end
  end
end

# Main loop
configure_window(version: 'v04')
show_image('teuton.png')
process_input
show

exit 0

