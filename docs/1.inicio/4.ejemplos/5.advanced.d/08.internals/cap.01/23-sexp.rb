#!/usr/bin/env ruby
require_relative "show"

code = <<STR
  2 + 2 * 3
STR
puts code

show_sexp code