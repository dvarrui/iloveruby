#!/usr/bin/env ruby

require_relative "lib/09-stepbystep-lib"

source = <<~RUBY
  a = 3
  b = 4
  c = a + b
  puts c
RUBY

StepByStep.call(source)
