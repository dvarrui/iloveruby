#!/usr/bin/env ruby
# Glimmer DSL for LibUI Version 2 (setting window properties instead of arguments):

require 'glimmer-dsl-libui'
include Glimmer

window { # first 3 args can be set via properties with 4th arg has_menubar=true by default
  title 'hello world'
  content_size 300, 200
  
  on_closing do
    puts 'Bye Bye'
  end
}.show

