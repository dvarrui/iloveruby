
class Input
  attr_reader :key

  def initialize(window)
    @key = Curses::KEY_RIGHT
    @window = window
  end

  def update
    prev_key = @key
    event = @window.getch()
    @key = event == -1 ? @key : event

    # TODO: It could be interesting... play using Joystick instead of keyboard
    @key = prev_key unless [Curses::KEY_DOWN,
                            Curses::KEY_UP,
                            Curses::KEY_RIGHT,
                            Curses::KEY_LEFT,
                            27].include?(@key)
    @key
  end
end
