
class String
  def lower
    self.downcase
  end

  def upper
    self.upcase
  end

  def replace(a, b)
    self.tr(a, b)
  end

  def format(arg)
    self % arg
  end
end
