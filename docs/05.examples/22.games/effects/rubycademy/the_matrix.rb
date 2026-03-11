#!/usr/bin/env ruby

require "colorize"

def clear_screen = puts "\033[2J"
def move_cursor(x, y) = print "\033[#{y};#{x}H"
def move_cursor_top_left = move_cursor(0, 0)

trap('SIGINT') { puts "Bye!"; exit! }

total_width = `stty size`.scan(/\d+/)[1].to_i
snowflake_positions = {}
colors = %I(green light_green white)
chars = (33..126).to_a + Array.new(100, " ")

clear_screen
loop do
  snowflake_positions[rand(total_width)] = 0

  snowflake_positions.each do |x, y|
    snowflake_positions[x] += 1
    move_cursor(x, y + 1)
    c = chars.sample.chr
    print c.to_s.send(colors.sample)
  end
  move_cursor_top_left
  sleep 0.1
end

