#!/usr/bin/env ruby

source_code = <<~RUBY
  x = 6
  x = x
RUBY

c = RubyVM::InstructionSequence.compile(source_code, peephole_optimization: true)
puts c.disasm

