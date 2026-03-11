class Disk
  attr_accessor :screen

  def initialize(screen, symbol)
    @screen = screen
    @symbol = symbol
    # @size = { x: (@screen.width - 2), y: (@screen.height - 10) }
    @size = { x: 75, y: (@screen.height - 9) }
    @pos = { x: 2, y: 2 }
    @max = @size[:x] * @size[:y] - @size[:x]/ 2
    @data = Array.new(@max) { :unused }
    @data[0] = :unmovable
    @index = 0
  end

  def progress
    ((@index / @max) * 100).to_i
  end

  def update(delta)
  end

  def render
    x = 0
    y = 0
    @data.each do |value|
      @screen.show @pos[:x] + x, @pos[:y] + y, @symbol[value]
      x += 1
      if x > @size[:x]
        x = 0
        y += 1
      end
    end
    @symbol.values.each_with_index do |s, index|
      @screen.show index+@pos[:x], @pos[:y] + 3, s
    end
  end
end
