#!/usr/bin/env ruby

require 'ffi'

ID="01"

module FfiCustomTest
  extend FFI::Library
  ffi_lib 'c'
  ffi_lib "./#{ID}-ffi.so"
  attach_function :ffi_pow, [ :int, :int ], :int
  attach_function :ffi_factorial, [ :int ], :int
  attach_function :ffi_fibonacci, [ :int ], :int
end

puts "FFI"
puts "├── Fibonnaci | 9    => #{FfiCustomTest.ffi_fibonacci(9)}"
puts "├── Pow       | 2,10 => #{FfiCustomTest.ffi_pow(2, 10)}"
puts "├── Factorial | 5    => #{FfiCustomTest.ffi_factorial(5)}"
puts "└── Factorial | 50   => #{FfiCustomTest.ffi_factorial(50)}"

def ruby_factorial(n)
  return 1 if n <= 1
  return n*ruby_factorial(n-1)
end

puts "Ruby"
puts "├── Factorial | 5    => #{ruby_factorial(5)}"
puts "└── Factorial | 50   => #{ruby_factorial(50)}"
