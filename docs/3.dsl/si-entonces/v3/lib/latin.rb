def si(cond)
  LatinConditional.new(cond)
end

def escribere(arg)
  puts arg
end

X = 10
XVII = 17
LV = 55

class LatinConditional
  def initialize(state)
    @state = state
    @done = false
  end

  def tum(&block)
    ejecutar(true, block)
  end

  def si_non(&block)
    ejecutar(false, block)
  end

  private
  
  def ejecutar(state, block)
    return self if @done

    if @state == state
      block.call
      @done = true
    end
    self
  end
end

class Integer
  def maior(other)
    self > other
  end

  def minor(other)
    self < other
  end

  def aequalis(other)
    self == other
  end
end
