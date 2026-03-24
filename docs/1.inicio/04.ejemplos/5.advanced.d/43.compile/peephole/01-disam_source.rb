#!/usr/bin/env ruby

source_code = <<~RUBY
  puts 9 + 8
RUBY

puts RubyVM::InstructionSequence.compile(source_code).disasm

