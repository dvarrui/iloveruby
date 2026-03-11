#!/usr/bin/env ruby
# https://github.com/whitequark/parser

# require "parser/current"
# puts Parser::CurrentRuby.parse("2 + 2")
# (send
#   (int 2) :+
#   (int 2))

require "parser/ruby31"
ast = Parser::Ruby31.parse("2 + 2")
puts ast
puts ast.class

