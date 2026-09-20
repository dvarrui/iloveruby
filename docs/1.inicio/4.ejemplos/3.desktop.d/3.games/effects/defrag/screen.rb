require "colorize"

class Screen
  attr_reader :width, :height

  def initialize
    terminal_size = `stty size`.scan(/\d+/)
    @width = terminal_size[1].to_i
    @height = terminal_size[0].to_i
  end

  def clear = puts "\033[2J"
  def move(x, y) = print "\033[#{y};#{x}H"
  def move_top_left = move(0, 0)
  def show(x, y, text)
    move(x,y)
    print text
  end
end
