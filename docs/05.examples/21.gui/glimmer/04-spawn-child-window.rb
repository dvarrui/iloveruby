#!/usr/bin/env ruby
# Basic Child Window

require 'glimmer-dsl-libui'
include Glimmer

def new_child_window
  window('Child Window') {
    on_closing do
      puts 'Child window is closing'
    end
  }.show
end

window('Main Window') {
  button('Spawn Child Window') {
    on_clicked { new_child_window }
  }
  
  on_closing do
    puts 'Main window is closing'
  end
}.show
