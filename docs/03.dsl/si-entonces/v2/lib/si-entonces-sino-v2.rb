def si(cond)
  SpanishConditional.new(cond)
end

class SpanishConditional
  def initialize(state)
    @state = state
    @done = false
  end

  def entonces(&block)
    return self if @done

    if @state == true
      block.call
      @done = true
    end
    self
  end

  def sino(&block)
    return self if @done

    if @state == false
      block.call
      @done = true
    end
    self
  end
end
