#!/usr/bin/env ruby
# frozen_string_literal: true

require 'tty-box'

box = TTY::Box.frame "Drawing a box in", "terminal emulator",
                     padding: 3, align: :center
puts box

