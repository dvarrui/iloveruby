
class MyMatrix
  attr_reader :size

  def initialize(args={ :size => 0, :value => 0, :identity => false})
    @data = []
    @size = args[:size]
    build args
  end

  def build(args)
    return build_identity if args[:identity]
    build_with(args[:value])
  end

  def build_with(value)
    size_iterator.each do |x|
      line = []
      size_iterator.each do |y|
        line << value
      end
      @data << line
    end
  end

  def build_identity()
    build_with 0
    size_iterator.each { |i| @data[i][i]=1 }
  end

  def to_s
    out = ''
    out << @data.to_s
    out << "\n"
  end

  def get(x,y)
    return @data[x][y] || 0
  end

  def set(x,y,value)
    @data[x][y]=value
  end

  def copy
    s = MyMatrix.new :size => size, :value => 0
    size_iterator.each do |x|
      size_iterator.each do |y|
        s.set(x,y, get(x,y))
      end
    end
    return s
  end

  def sum(other)
    s = other.copy
    size_iterator.each do |x|
      size_iterator.each do |y|
        value = self.get(x,y) + s.get(x,y)
        s.set(x,y, value)
      end
    end
    return s
  end

  private
  def size_iterator
    (0..(size-1))
  end
end
