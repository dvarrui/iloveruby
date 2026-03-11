
require_relative 'life-game/game'

module LifeGame
  def self.play(filename)
    game = Game.new(filename)
    game.play
  end
end
