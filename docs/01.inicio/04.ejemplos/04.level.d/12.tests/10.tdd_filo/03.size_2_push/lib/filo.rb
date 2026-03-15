
class Filo
  attr_reader :size

  def initialize
    @size = 0
  end

  def empty?
    true
  end

  def push(element)
    @size += 1
  end

end
