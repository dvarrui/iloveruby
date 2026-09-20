def si(block, scope = binding)
  SpanishConditional.new(scope).si(block)
end

class SpanishConditional
  def initialize(scope)
    @scope = scope
  end

  def si(block)
    result = eval(block, @scope)
    if result
      @state = true
    else
      @state = false
    end
    self
  end

  def entonces(block)
    if @state == true
      @scope = eval(block + "; binding", @scope)
      @state = nil
    end
    self
  end

  def sino(block)
    if @state == false
      @scope = eval(block + "; binding", @scope)
      @state = nil
    end
    self
  end
end
