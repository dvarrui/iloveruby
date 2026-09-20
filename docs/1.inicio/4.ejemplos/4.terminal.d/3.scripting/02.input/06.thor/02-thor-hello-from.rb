#!/usr/bin/env ruby
require "thor"

class MyCLI < Thor
  desc "hello NAME [FROM_NAME]", "say hello to NAME"

  def hello(name, from=nil)
    puts "from: #{from}" if from
    puts "Hello #{name}"
  end
end

MyCLI.start(ARGV)
