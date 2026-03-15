#!/usr/bin/env ruby
require "thor"

class MyCLI < Thor
  desc "hello NAME", "say hello to NAME"
  option :from
  def hello(name)
    puts "from: #{options[:from]}" if options[:from]
    puts "Hello #{name}"
  end
end

MyCLI.start(ARGV)
