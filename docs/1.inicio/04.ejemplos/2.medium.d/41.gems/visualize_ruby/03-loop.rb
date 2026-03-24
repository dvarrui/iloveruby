#!/usr/bin/env ruby

require "visualize_ruby"

ruby_code = <<~RUBY
  class Looping
    def call
      (0..5).each do
        paint_town!
      end
    end

    def paint_town!
      "hello"
    end
  end
RUBY

VisualizeRuby.new do |vb|
  vb.ruby_code = ruby_code # String, File, Pathname
  vb.trace do
    Looping.new.call
  end
  vb.output_path = "output_loop.png" # file name with media extension.
  # in_line_local_method_calls = true # default, in line method body when calling methods on self. Looks better when tracing execution.
  # only_graphs = ["call"] # When a graph has many sub-graphs only include listed.
  # unique_nodes = true # default, Duplicate nodes with the same description are merged to point single node.
end
