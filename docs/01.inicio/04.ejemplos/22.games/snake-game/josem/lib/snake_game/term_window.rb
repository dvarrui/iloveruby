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

  def paint_food(food)
    self.setpos(food.y, food.x)
    self.addstr(food.symbol)
    self.refresh
  end

  def paint_snake(snake)
    self.setpos(snake[0][1], snake[0][0])
    self.addstr(Snake::SYMBOL)
    self.refresh
  end
end
