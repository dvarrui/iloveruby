
class Food
  attr_accessor :window, :points, :symbol, :x, :y

  DEFAULT_SYMBOL = "*"

  def initialize(window, x = nil, y = nil)
    @window = window
    @x = x || generate_random_x
    @y = y || generate_random_y
    @symbol = DEFAULT_SYMBOL
    @points = 1
  end

  def has_been_eaten_by?(snake)
    #binding.pry
    snake[0][0] == x && snake[0][1] == y
  end

  def relocate_without_conflict!(snake)
    if snake.include? [x, y]
      x = generate_random_x
      y = generate_random_y
    end
  end

  private

  def generate_random_x
    Random.rand(1..@window.width - 2)
  end

  def generate_random_y
    Random.rand(1..@window.height - 2)
  end
end
