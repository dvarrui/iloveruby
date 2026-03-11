class Progress
  attr_accessor :value

  def initialize(screen, symbol)
    @screen = screen
    @symbol = symbol
    @duration = 0.0
    @value = 0.0
    @bar = 35
  end

  def update(delta)
    @duration += delta
    @min = format("%02d", @duration/60).on_blue
    @seg = format("%02d", (@duration - (@duration/60).to_i * 60)).on_blue

    @value += delta * 2
    exit if @value > 100
  end

  def render
    y = @screen.height

    done = ((@bar * @value) / 100).to_i
    rest = @bar - done
    bar = @symbol[:done] * done + @symbol[:unused] * rest

    @screen.show 35, y - 5, format("%3d", @value).on_blue
    @screen.show 4, y - 4, bar
    @screen.show 28, y - 3, @min
    @screen.show 31, y - 3, @seg
  end
end
