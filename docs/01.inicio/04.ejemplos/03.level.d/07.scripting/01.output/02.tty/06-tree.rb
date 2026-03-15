#!/usr/bin/env ruby
# frozen_string_literal: true

require 'tty-tree'

lib = File.expand_path("..", __dir__)

tree = TTY::Tree.new(lib)

puts tree.render(as: :dir)
