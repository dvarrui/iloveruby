
class Player
  attr_accessor :x, :y

  def initialize(screen)
    @screen = screen
  end

  def update
  end

  def render
    @screen.show(@x, @y, "#".cyan)
  end
end
