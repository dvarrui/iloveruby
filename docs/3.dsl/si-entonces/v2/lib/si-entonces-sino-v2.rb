def si(cond)
  SpanishConditional.new(cond)
end

class SpanishConditional
  def initialize(state)
    @state = state
    @done = false
  end

  def entonces(&block)
    ejecutar(true, block)
  end

  def sino(&block)
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
