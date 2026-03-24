#!/usr/bin/env ruby
# http://rubylearning.com/blog/2013/04/04/ruby-matrix-the-forgotten-library/

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

a = MyMatrix.new :size => 2, :value => 0
puts "MyMatrix A #{a.to_s}"

b = MyMatrix.new :size => 2, :value => 3
puts "MyMatrix B #{b.to_s}"

c = MyMatrix.new :size => 2, :identity => true
puts "MyMatrix C #{c.to_s}"
