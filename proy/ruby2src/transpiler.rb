#!/usr/bin/env ruby
require_relative 'lib/ruby2basic'
require_relative 'lib/ruby2c'

if ARGV.empty?
  puts "Usage: #{$0} INPUTFILE.rb [basic|c]"
  exit 1
end

input_file = ARGV[0]
input_source_code = File.read(input_file)
puts input_source_code

target = ARGV[1].downcase.to_sym
transpiler = if target == :basic
  Ruby2Basic.new
else
  Ruby2C.new
end

result = transpiler.call(input_source_code)
    
output_file = input_file.gsub('.rb', '.bas')
puts "==> File: #{output_file}"
puts result
