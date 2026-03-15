
require "curses"
require_relative "textbox"

module Turbo
  extend Curses

  def self.init
    init_screen
    crmode
    cbreak
    noecho
    if !Curses.has_colors?
      addstr "This Terminal does not support colors!"
    else
      start_color
      (0..15).each { |i| Curses.init_pair(i, i, 0) }
    end

    stdscr.keypad = true
    at_exit do
      Curses.close_screen
    end
    build
  end

  def self.build
    Curses.attrset(Curses.color_pair(0))
    setpos(22,3); addstr("-" * 90)
    setpos(23,3); addstr("[ ESC ]")
    setpos(24,3); addstr("  Quit")

    boxes = []
    boxes << TextBox.new(x:7, y:4, w:89, h:18)
    boxes
  end

  def self.run
    boxes = init
    boxes[0].run
    close(boxes)
  end

  def self.close(boxes)
    close_screen
  end
end
