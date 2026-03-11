#!/usr/bin/env ruby

require 'curses'

module Curses
  def self.program
    main_screen = init_screen
    noecho
    cbreak
    curs_set(0)
    main_screen.keypad = true
    yield main_screen
  end
end

Curses.program do |scr|
  x = 10
  y = 10
  loop do
    scr.setpos(y, x); scr.addstr("@")
    sleep 0.1
    str = scr.getch.to_s

    scr.setpos(y, x); scr.addstr(" ")
    x += 1 if str == 'd'
    x -= 1 if str == 'a'
    y -= 1 if str == 'w'
    y += 1 if str == 's'
  end
end
