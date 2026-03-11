#!/usr/bin/env ruby

# /tmp/proc.rb
p = proc { puts 9 + 8 }
puts RubyVM::InstructionSequence.disasm(p)
