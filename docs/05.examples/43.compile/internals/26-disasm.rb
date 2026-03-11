#!/usr/bin/env ruby 
require 'ripper'
require 'pp'

code = File.read("21-script.rb")
puts code
puts RubyVM::InstructionSequence.compile(code).disasm
