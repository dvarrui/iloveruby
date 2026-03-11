#!/usr/bin/env ruby

require "visualize_ruby"

ruby_code = <<~RUBY
  if hungry?
    eat
  else
    work
  end
RUBY

results = VisualizeRuby::Builder.new(ruby_code: ruby_code).build
VisualizeRuby::Graphviz.new(results).to_graph(path: "output_example.png")
