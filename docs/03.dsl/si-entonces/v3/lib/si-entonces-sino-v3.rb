def si(cond, scope = binding)
  SpanishConditional.new(scope).si(cond)
end

class SpanishConditional
  def initialize(scope)
    @scope = scope
  end

  def si(cond)
    @state = cond
    self
  end

  def entonces(&block)
    if @state == true
      block.call
      @state = nil
    end
    self
  end

  def sino(&block)
    if @state == false
      block.call
      @state = nil
    end
    self
  end
end
