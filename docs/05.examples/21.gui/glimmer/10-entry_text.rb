#!/usr/bin/env ruby
# Glimmer DSL for LibUI Version 2 (without data-binding):

require 'glimmer-dsl-libui'
include Glimmer

window('Basic Entry', 300, 50) {
  horizontal_box {
    e = entry {
      # Smart default option for appending to horizontal_box
      stretchy true

      on_changed do
        puts e.text
        $stdout.flush # For Windows
      end
    }

    button('Button') {
      # stretchy property is available when control is nested under horizontal_box
      stretchy false
      on_clicked do
        text = e.text
        msg_box('You entered', text)
      end
    }
  }

  on_closing do
    puts 'Bye Bye'
  end
}.show
