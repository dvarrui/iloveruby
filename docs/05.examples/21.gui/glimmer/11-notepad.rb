#!/usr/bin/env ruby
# Glimmer DSL for LibUI Version:

require 'glimmer-dsl-libui'
include Glimmer

window('Notepad', 500, 300) {
  on_closing do
    puts 'Bye Bye'
  end

  vertical_box {
    non_wrapping_multiline_entry
  }
}.show
