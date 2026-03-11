#!/usr/bin/env ruby

require "visualize_ruby"

ruby_code = <<~RUBY
  class Worker
    def initialize(hungry:)
      @hungry = hungry
    end

    def next_action
      if hungry?
        :eat
      else
        :work
      end
    end

    def hungry?
      @hungry
    end
  end
RUBY

calling_code = <<~RUBY
  Worker.new(hungry: true).next_action
RUBY

VisualizeRuby.new do |vb|
  vb.ruby_code = ruby_code # String, File, Pathname
  vb.trace(calling_code)  # String, File, Pathname, Proc - optional
  vb.output_path = "output_runner_trace.png" # file name with media extension.
end
