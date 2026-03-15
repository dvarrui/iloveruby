
class Nubex
  attr_reader :data
  
  def initialize(base, exp = 1)
    @data = { base => exp }
  end

  def to_i
    acc = 1
    @data.each { |key, value| acc *= key ** value }
    acc
  end

  def to_s
    out = []
    @data.sort.each do |item|
      if item[1] == 1
        out << item[0].to_s if item[0] != 1
      else
        out << "#{item[0]}^#{item[1]}"
      end
    end
    out.join('*')
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

end
