
require 'curses'

class Output
  INVISIBLE_CURSOR = 0

  def initialize(window)
    @window = window
  end

  def print_at(text, y, x)
    @window.setpos(y, x)
    @window.addstr(text.to_s)
  end

  def paint(node)
    @window.setpos(node.y, node.x)
    @window.addstr(node.symbol)
  end

  def self.init
    Curses.init_screen()
    Curses.cbreak()
    Curses.noecho
    Curses.curs_set(INVISIBLE_CURSOR)
  end

  def self.close
    Curses.close_screen
  end
end
