#!/usr/bin/env ruby
require "pastel"

require_relative "lib/basic/ruby2basic"
require_relative "lib/c/ruby2c"

def check_input
  if ARGV.empty?
    puts "Usage: #{$0} INPUTFILE.rb [basic|c|riscv]"
    exit 1
  end
  @input_file = ARGV[0]
  @target = ARGV[1].downcase.to_sym
end

def load_input
  @input_source_code = File.read(@input_file)
  @pastel = Pastel.new
  puts @pastel.green(@input_source_code)
  @translater = if @target == :basic
    Ruby2Basic.new
  else
    Ruby2C.new
  end
end

def translate
  @result = @translater.call(@input_source_code)
end

def show
  output_file = @input_file.gsub('.rb', '.bas')
  puts "==> File: #{output_file}"
  puts @pastel.cyan(@result)
end

check_input
load_input
translate
show