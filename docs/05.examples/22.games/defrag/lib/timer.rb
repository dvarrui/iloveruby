class Timer
  attr_accessor :seg

  def initialize
    @duration = 0.0
    @seg = 0.0
  end

  def update(delta)
    @duration += delta
    if @duration >= @seg
      @duration -= @seg
      timeout
    end
  end
end
