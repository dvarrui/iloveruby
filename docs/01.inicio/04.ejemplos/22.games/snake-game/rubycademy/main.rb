#!/usr/bin/env ruby
# frozen_string_literal: true
# URL. https://www.youtube.com/watch?v=nnoYJxaFw3Q

require "io/console"
require "colorize"
require "debug"

# micro-framework to manipulate the cursor

def clear_screen = puts "\033[2J"
def move_cursor(x, y) = print "\033[#{y};#{x}H"
def move_cursor_top_left = move_cursor(0, 0)
def total_height = @total_height ||= `stty size`.scan(/\d+/)[0].to_i
def total_width = @total_width ||= `stty size`.scan(/\d+/)[1].to_i

block = "#".red.on_light_white
head_block = "#".light_white.on_red
food = "*".on_yellow
food_x, food_y = [ rand(2..total_width-2), rand(2..total_height-2)]
score = 0

positions = [
  [total_width/2, total_height/2],
  [total_width/2 + 1, total_height/2],
  [total_width/2 + 2, total_height/2],
  [total_width/2 + 3, total_height/2],
]

$direction = "C"
Thread.new do
  STDIN.noecho do |io|
    while c = io.getch.tap { |char| exit(1) if char == "\u0003" }
      if %w(A B).include?($direction) && %w(C D).include?(c.chr)
        $direction = c.chr
      elsif %w(C D).include?($direction) && %w(A B).include?(c.chr)
        $direction = c.chr
      end
    end
  end
end

loop do
  x, y = positions.last
  positions.push(
    case $direction
    when "A" then y.positive? ? [x, y-1] : [x, total_height]
    when "B" then y < total_height ? [x, y+1] : [x, 0]
    when "D" then x.positive? ? [x-1, y] : [total_width, y]
    when "C" then x < total_width ? [x+1, y] : [0, y]
    end
    )

  head = positions.last
  break if positions[0..-2].any? { |x, y| head[0] == x && head[1] == y }

  if head[0] == food_x && head[1] == food_y
    food_x, food_y = [ rand(2..total_width-2), rand(2..total_height-2)]
    score += 1
  else
    positions.shift
  end

  clear_screen
  positions[0..-2].each do |x, y|
    move_cursor(x, y)
    print block
  end

  # binding.break
  move_cursor *head
  print head_block

  move_cursor food_x, food_y
  print food

  move_cursor 0, 0
  print "Score:#{score}"
  move_cursor total_width,0
  sleep 0.05
end

clear_screen
move_cursor_top_left
puts "Game over! Your score: #{score.to_s.red}"
