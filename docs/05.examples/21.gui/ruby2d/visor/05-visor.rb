#!/usr/bin/env ruby

require 'ruby2d'

class Scene
  OFFSET = 800

  def initialize(filepath, index)
    @filepath = filepath
    @index = index

    @x = 50 + @index * OFFSET
    filename = File.basename(@filepath)
    @image = Image.new(@filepath, x: @x, y: 100)
    @text = Text.new("Filename: #{filename}", x: @x, y: 50, size: 40, color: 'white', z: 10)
  end

  def offset(value)
    return if value.zero?
    @image.x = @x + value * OFFSET
    @text.x = @x + value * OFFSET
  end
end

def configuration(version:)
  set title: "visor #{version} (ruby2d)"
  set background: 'navy'
  set width: 800
  set height: 600
end

def load_images_names
  dirbase = File.join(File.dirname(__FILE__), '..', 'images')
  Dir.glob(dirbase + '/*')
end

def create_scenes
  filepaths = load_images_names
  @scenes = []
  filepaths.each_with_index do |filepath, index|
    @scenes << Scene.new(filepath, index)
  end
  @scenes
end

def process_input
  offset = 0
  on :key_down do |event|
    if ['q', 'escape', 'e'].include? event.key
      close
    elsif event.key == 'right'
      offset += 1
    elsif event.key == 'left'
      offset -=1
    end
    puts "#{event.key}, #{offset}"
    @scenes.each { |scene| scene.offset(offset) }
  end
end

configuration(version: 'v05')
create_scenes
process_input
show
