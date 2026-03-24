#!/usr/bin/env ruby
# https://github.com/whitequark/parser

require "parser/ruby31"

source = <<~RUBY
  a = 3
  b = 4
  c = a + b
RUBY
ast = Parser::Ruby31.parse(source)
puts ast
puts ast.class

require "debug"
binding.break
