# File: turtle.rb
# El motor del DSL Logo es la clase Turtle

class Turtle
  def initialize
    @x, @y = 0.0, 0.0
    @angle = 0 # En grados
    @pen_down = true
  end

  def forward(steps)
    new_x = @x + steps * Math.cos(@angle * Math::PI / 180)
    new_y = @y + steps * Math.sin(@angle * Math::PI / 180)
    
    puts "Dibujando desde [#{@x.round(2)}, #{@y.round(2)}] hasta [#{new_x.round(2)}, #{new_y.round(2)}]" if @pen_down
    
    @x, @y = new_x, new_y
  end

  def right(degrees)
    @angle += degrees
  end

  def left(degrees)
    @angle -= degrees
  end

  def pen_up;   @pen_down = false; end
  def pen_down; @pen_down = true;  end

  # Aliases para imitar los comandos cortos de Logo
  alias_method :fd, :forward
  alias_method :rt, :right
  alias_method :lt, :left
  alias_method :pu, :pen_up
  alias_method :pd, :pen_down

  def repeat(ntimes, &block)
    # ntimes.times block.call
    ntimes.times { block.call }
  end
end

