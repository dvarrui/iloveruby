require_relative "lib/disk"
require_relative "lib/panel"
require_relative "lib/progress"

class Scene
  attr_accessor :screen

  def init
    @symbol = {
      space: " ".on_blue,
      done: " ".on_light_white,
      used1: "\u25cf".blue.on_light_yellow,
      used2: "\u25cf".blue.on_light_white,
      unused: " ".on_light_black, # white,
      reading: "r".light_white.on_blue,
      writting: "W".light_white.on_blue,
      bad: "B".light_white.on_blue,
      unmovable: "X".light_white.on_blue,
    }
    @panel = Panel.new(@screen, @symbol)
    @disk = Disk.new(@screen, @symbol)
    @progress = Progress.new(@screen, @symbol)
  end

  def update(delta)
    @panel.update(delta)
    @disk.update(delta)
    # @progress.value = @disk.progress
    @progress.update(delta)
  end

  def render
    @panel.render
    @disk.render
    @progress.render
  end
end
