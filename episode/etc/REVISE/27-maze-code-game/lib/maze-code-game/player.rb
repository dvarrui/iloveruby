
##
# Player actor
class Player
  def initialize
    @sprite = init
  end

  def init
    Sprite.new('lib/maze-code-game/image/hero.png',
               width: 78,
               height: 99,
               clip_width: 78,
               time: 250,
               animations: { walk: 1..2,
                             climb: 3..4,
                             cheer: 5..6 }
              )
  end

  def left
    @sprite.play animation: :walk, loop: true, flip: :horizontal
  end

  def right
    @sprite.play animation: :walk, loop: true
  end

  def up
    @sprite.play animation: :climb, loop: true
  end

  def down
    @sprite.play animation: :climb, loop: true, flip: :vertical
  end

  def c
    @sprite.play animation: :cheer
  end
end
