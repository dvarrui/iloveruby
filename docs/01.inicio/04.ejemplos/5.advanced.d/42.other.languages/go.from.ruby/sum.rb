#!/usr/bin/env ruby
require 'ffi'

module Maths
  extend FFI::Library
  ffi_lib './sum.so'
  attach_function :sum, [:int, :int], :int
end

puts Maths.sum(ARGV[0].to_i, ARGV[1].to_i)
# ruby sum.rb 23 60
# => 83
