require 'curses'

class TermWindow < Curses::Window
  DEFAULT_WIDTH = 80
  DEFAULT_HEIGHT = 20

  attr_accessor :width, :height

  def initialize(height = DEFAULT_HEIGHT, width = DEFAULT_WIDTH)
    super(height, width, 0, 0)
    @width, @height = width, height
    self.box(?|, ?-)
    self.keypad(true)
  end
end
