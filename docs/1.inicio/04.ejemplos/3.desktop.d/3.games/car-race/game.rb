
require_relative "screen"

trap('SIGINT') { puts "Bye!"; exit! }

class Game
  def initialize(scene)
    @screen = Screen.new
    @scene = scene
    @scene.screen = @screen
    @scene.init
  end

  def run
    @screen.clear
    timestamp = Time.now

    loop do
      delta = Time.new - timestamp
      timestamp = Time.new

      @scene.update(delta)
      @scene.render
      @screen.move_top_left

      wait = 0.2
      sleep(wait - delta) if delta < wait
    end
  end
end
