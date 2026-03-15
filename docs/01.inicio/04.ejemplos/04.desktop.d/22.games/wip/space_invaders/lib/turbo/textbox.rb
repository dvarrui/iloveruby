
require 'curses'

class TextBox
  attr_reader :data

  def initialize(x:, y:, w:, h:)
    point_class = Struct.new(:x, :y)
    @position = point_class.new(6, 1)
    size_class = Struct.new(:w, :h)
    @size = size_class.new(w, h)
    @cursor = point_class.new(0, 0)
    @data = [ '', '' ]
  end

  def run
    render
    loop do
      ch = Curses.get_char
      internal_debug
      case ch
      when "\e" # ESC
        return
      when "\n" #Curses::KEY_DOWN
        key_enter
      when Curses::KEY_DOWN
        key_down
      when Curses::KEY_UP
        key_up
      when Curses::KEY_BACKSPACE
        key_backspace
      when 330
        key_delete
      when Curses::KEY_LEFT
        key_left
      when Curses::KEY_RIGHT
        key_right
      else
        add_char(ch)
      end
      render
    end
  end

  def render
    @data.each_with_index do |line, index|
      y = @position.y + index
      x = @position.x
      tail = '  '
      tail = '$ ' if line.size == @size.w
      Curses.attrset(Curses.color_pair(15))
      write_xy(x, y, line)
      write_xy(x + line.size, y, tail)
      Curses.attrset(Curses.color_pair(0))
      write_xy(x -5 , y, "%3d:" % (index+1))
      Curses.attrset(Curses.color_pair(15))
    end

    pos = global_position
    write_xy(pos.x, pos.y, '')
  end

  def write_xy(x, y, text)
    Curses.setpos(y, x);
    Curses.addstr(text)
  end

  private

  def internal_debug
    point_class = Struct.new(:x, :y)
    pos = point_class.new( @position.x + @cursor.x,
                           @position.y + @cursor.y )

    line = @data[@cursor.y]
    msg = "[DEBUG] " \
          "Data: lines=#{@data.size}, size=#{line.size}, current_line=<#{line}>      "
    write_xy(3, 19, msg)
  end

  def global_position
    point_class = Struct.new(:x, :y)
    pos = point_class.new( @position.x + @cursor.x,
                           @position.y + @cursor.y )
    pos
  end

  def current_line
    @data[@cursor.y]
  end

  def key_backspace
    return if @cursor.x.zero?

    current_line[@cursor.x - 1] = ''
    @cursor.x -= 1
  end

  def key_delete
    return if current_line.size.zero?
    return if @cursor.x == current_line.size

    current_line[@cursor.x] = ''
  end

  def key_left
    return if @cursor.x.zero?

    @cursor.x -= 1
  end

  def key_right
    return if @cursor.x >= @size.w

    @cursor.x += 1 if @cursor.x < current_line.size
  end

  def key_up
    return if @cursor.y.zero?

    @cursor.y -= 1
    @cursor.x = current_line.size if @cursor.x >= current_line.size
  end

  def key_enter
    return if @cursor.y >= @size.h

    @cursor.y += 1
    @data << "" if current_line.nil?
    @cursor.x = 0
  end

  def key_down
    return if @cursor.y >= @size.h
    return if @data[@cursor.y + 1].nil?

    @cursor.y += 1
    @cursor.x = current_line.size if @cursor.x >= current_line.size
  end

  def add_char(ch)
    return if @cursor.x >= @size.w or current_line.size == @size.w

    if @cursor.x == current_line.size
      @data[@cursor.y] << ch
    else
      require 'debug'; binding.break
      @data[@cursor.y].insert(@cursor.x, ch)
    end
    @cursor.x += 1
  end
end
