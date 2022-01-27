
class Circuito
  attr_reader :carretera

  def initialize
    @carretera = [15,15,15,15,15,15,15,15,15,15]
  end

  def render
    puts "---"
    @carretera.each do |i|
      i.times { |j| print ' ' }
      puts '|     |'
    end
  end

  def update
    n = rand(3)-1
    c = Array.new
    c << (@carretera[0]+n)
    0..9.times { |i| c << @carretera[i] }
    @carretera = c
  end
end
