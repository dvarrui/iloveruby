require_relative "world"
require_relative "player"

class Level
  attr_accessor :screen

  def init
    @world = World.new(@screen)
    @player = Player.new(@screen)
    @player.x = 60
    @player.y = 20
  end

  def update(delta)
    @world.update
    @player.update
  end

  def render
    @world.render
    @player.render
  end
end
