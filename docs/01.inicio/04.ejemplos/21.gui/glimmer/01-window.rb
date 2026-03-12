#!/usr/bin/env ruby
# Glimmer DSL for LibUI Version:

require 'glimmer-dsl-libui'
include Glimmer

window('hello world', 300, 200, true) {
  on_closing do
    puts 'Bye Bye'
  end
}.show
