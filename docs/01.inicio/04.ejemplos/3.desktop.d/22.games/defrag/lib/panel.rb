class Panel
  def initialize(screen, symbol)
    @screen = screen
    @symbol = symbol
    @panel = File.read(File.join("lib", "panel.txt")).on_blue
    @state = :init
  end

  def update(delta)
  end

  def render
    if @state == :init
      fill_screen
      show_panel
      @state = :running
    end
  end

  private

  def fill_screen
    (1..@screen.height).each do |y|
      (1..@screen.width).each do |x|
        @screen.show x, y, @symbol[:space]
      end
    end
  end

  def show_panel
    y = @screen.height - 6
    x = 45
    @screen.show 1, y, @panel
    @screen.show x, y + 1, @symbol[:used2]
    @screen.show x + 17, y + 1, @symbol[:unused]
    @screen.show 17, y, " Status ".light_yellow.on_blue
    @screen.show 57, y, " Legend ".light_yellow.on_blue
  end
end
