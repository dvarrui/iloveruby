#!/usr/bin/env ruby

clear_screen = -> { puts "\033[2J" }

trap("SIGINT") do
  clear_screen.call

  puts "Morpheus: 'Follow me.'"
  exit!
end

total_width = `stty size`.scan(/\d+/)[1].to_i # terminal width

chars = {}
eligible_chars = ('a'..'z').to_a + ('1'..'9').to_a + ['.', ' ']

clear_screen.call

loop do
  chars[rand(total_width)] = 0

  chars.each do |column, row|
    chars[column] += 1 # increment row value

    print "\033[#{row + 1};#{column}H" # move cursor down (row + 1)
    print "#{eligible_chars.sample} "  # print random character
    print "\033[0;0H"                  # move cursor to top/left position
  end
  sleep 0.1
end
