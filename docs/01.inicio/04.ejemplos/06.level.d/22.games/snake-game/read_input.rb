#!/usr/bin/env ruby

require "io/console"

trap('SIGINT') { puts "Bye!"; exit! }

counter = 0
STDIN.noecho do |io|
  # while c = io.getch.tap { |char| exit(1) if char == "\e" }
  while c = io.getch
    puts "#{c.chr} #{c}"
    counter += 1
    exit if counter > 10
  end
end
