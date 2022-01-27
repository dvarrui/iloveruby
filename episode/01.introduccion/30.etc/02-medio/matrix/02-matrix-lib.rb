
class MyMatrix
  def initialize(args={ :size => 0, :value => 0, :identity => false})
    @data = []
    @size = args[:size]-1
    build args
  end

  def build(args)
    return build_identity if args[:identity]
    build_with(args[:value])
  end

  def build_with(value)
    (0..@size).each do |x|
      line = []
      (0..@size).each do |y|
        line << value
      end
      @data << line
    end
  end

  def build_identity()
    build_with 0
    (0..@size).each { |i| @data[i][i]=1 }
  end

  def to_s
    out = ''
    out << @data.to_s
    out << "\n"
  end
end
