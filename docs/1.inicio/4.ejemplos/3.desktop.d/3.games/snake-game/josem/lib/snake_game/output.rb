
class Output
  INVISIBLE_CURSOR = 0

  def initialize(window, debug = false)
    @window = window
    @debug = debug
    require 'curses' unless @debug
  end

  def print_at(text, x, y)
    return if @debug
    @window.setpos(x, y)
    @window.addstr(text.to_s)
  end

  def self.init
    return if @debug
    Curses.init_screen()
    Curses.cbreak()
    Curses.noecho
    Curses.curs_set(INVISIBLE_CURSOR)
  end

  def self.close
    return if @debug
    Curses.close_screen
  end
end
