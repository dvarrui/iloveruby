
class World
  attr_accessor :output
  attr_reader :step
  attr_reader :origin

  def initialize(x:, y:, filename:)
    @step = 0
    @origin = Struct.new(:x, :y).new(x, y)

    @filename = filename
    @data = load(filename)
  end

  def render
    @data.each_with_index do |row, rowindex|
      row.each_with_index do |cell, colindex|
        x = origin.x + colindex
        y = origin.y + rowindex
        @output.print_at(cell, y, x)
      end
    end
  end

  def update
    @step += 1
  end

  private

  def load(filename)
    map = ""
    map += "..00........\n"
    map += ".......000..\n"
    map += ".........0..\n"
    map += ".0.......0..\n"
    map += ".0.......0..\n"
    map += ".0..........\n"
    map += "......00....\n"
    map += "............\n"

    map.gsub!('.', ' ')
    @data = map.split("\n")
    @data.map! { _1.chars}
    @data
  end
end
