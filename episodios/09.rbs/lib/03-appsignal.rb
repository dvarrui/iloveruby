
class Super
    def initialize(val)
      @val = val
    end

    def val?
      @val
    end
end

class Test < Super
  def initialize(val, flag)
    super(val)
    @flag = flag
  end

  def flag?
    @flag
  end
end
