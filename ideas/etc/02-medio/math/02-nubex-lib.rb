
class Nubex
  attr_reader :data
<<<<<<< HEAD
  
  def initialize(base = 0, exp = 1)
    @data = {}
    @data[base] = exp
  end

  def value
    s = 0
    @data.each do |key, value|
      if value.zero?
        acc = key
      elsif value > 0
        acc = 1
        value.times { acc *= key}
      end
      s += acc
    end
    s
  end

  def mul(other)
  end

  def to_s
    s = ''
    @data.each { |key, value| s += "#{key}^#{value} " }
    s
  end
=======

  def initialize(base, exp = 1)
    @data = { base => exp }
  end

  def to_i
    acc = 1
    @data.each { |key, value| acc *= key ** value }
    acc
  end

  def to_s
    out = ''
    @data.sort.each do |item|
      if item[1] == 1
        out += "#{item[0]} " if item[0] != 1
      else
        out += "#{item[0]}^#{item[1]} "
      end
    end
    out
  end

  def mul(other)
    other.data.each do |key, value|
      if @data[key].nil?
        @data[key] = value
      else
        @data[key] += value
        @data.delete(key) if @data[key].zero?
      end
    end
  end

  def self.factorize(n)
    factors = []
    f = n
    (2..n).each do |i|
      while f%i == 0
        factors << i
        f = f / i
      end
    end
    #@data = { 1 => 1 }
    factors.to_s
    a = Nubex.new(1)
    factors.each { |i| a.mul(Nubex.new(i)) }
    a
  end

>>>>>>> 916457ddfd39b25ae95503203287d0cbb8932b63
end
