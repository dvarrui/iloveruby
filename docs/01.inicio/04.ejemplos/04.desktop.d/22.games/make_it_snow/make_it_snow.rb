#!/usr/bin/env ruby
# make_it_snow.rb
# https://gist.github.com/mehdi-farsi/0fa6622d768f926163fb6e4d5a66e57f

trap("SIGINT") { exit! }

total_width = `stty size`.scan(/\d+/)[1].to_i # terminal width
snowflakes = {}
puts "\033[2J"; # clearing output

loop do
  snowflakes[rand(total_width)] = 0

  snowflakes.each do |column, row|
    snowflakes[column] += 1 # increment row value

    print "\033[#{row};#{column}H" + " " # move cursor to [row, column] and replace current ❃ by a space
    print "\033[#{row + 1};#{column}H"   # move cursor down (row + 1)
    print "❃ "                           # print snowflake
    print "\033[0;0H"                    # move cursor to top/left position (cursor doesn't follow snowflake)
  end
  sleep 0.1
end
