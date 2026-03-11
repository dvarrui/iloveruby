
class Panel
  attr_reader :data

  def initialize
    @size = 4
    @data = []
    @size.times { @data <<= Array.new(@size, 0) }
  end

  def to_s
    @data.to_s
  end

  def random_fill
    max = 2
    for y in (0..max)
      for x in (0..max)
        # Número aleatorio entre 1 y 9
        @data[y][x] = rand(9) + 1
      end
    end
  end

  def calculate_sum
    calculate_rows_sum
    calculate_cols_sum
    calculate_diagonal_sum
  end

  def put_holes
    save = [ 0, 1, 2 ].shuffle!

    for y in 0..2
      for x in 0..2
        unless x == save[y]
          @data[y][x] = 0
        end
      end
    end
  end

  def self.create(max)
    max.times do |index|
      number = index + 1
      puts ""
      puts "-------------------------"
      puts "[#{number}] Solución y enunciado\n"
      panel = Panel.new
      panel.random_fill
      panel.calculate_sum
      PrettyColor.print panel

      puts ""
      panel.put_holes
      Pretty.print panel
    end
  end

  private

  def calculate_rows_sum
    @data.each do |row|
      row[3] = 0
      row[3] = row.sum
    end
  end

  def calculate_cols_sum
    for x in 0..2
      numbers = []
      for y in 0..2
        numbers << @data[y][x]
      end
      @data[3][x] = numbers.sum
    end
  end

  def calculate_diagonal_sum
    numbers = []
    for xy in 0..2
      numbers << @data[xy][xy]
    end
    @data[3][3] = numbers.sum
  end
end
