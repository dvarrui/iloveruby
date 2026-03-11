
class Combination

  def initialize(*input)
    values = input
    values = [0, 0, 0] if input == []
    @data = values
  end

  def to_s
    @data.to_s
  end

  def value
    @data
  end

  def next
    digit2 = @data[2]
    digit1 = @data[1]
    digit0 = @data[0]

    digit2 += 1
    if digit2 > 9
      digit2 = 0
      digit1 +=1
    end

    if digit1 > 9
      digit1 = 0
      digit0 +=1
    end

    if digit0 > 9
      digit0 = 0
      digit1 = 0
      digit2 = 0
    end
    Combination.new(digit0, digit1, digit2)
  end

  def next!
    combi = self.next
    @data = combi.value
    self
  end

end
