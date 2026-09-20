
class Filo

  def initialize(max_size = 10)
    @max_size = max_size
    @elements = Array.new(@max_size + 1,nil)
    @push_index = 0
    @pop_index = 0
  end

  def size
    (@push_index - @pop_index).abs
  end

  def empty?
    size.zero?
  end

  def push(element)
    if size == @max_size
      raise "Can't store more than #{@max_size} elements!"
    end
    @elements[@push_index] = element
    @push_index = inc_index(@push_index)
  end

  def pop
    return nil if size.zero?
    # require 'debug'; binding.break
    output = @elements[@pop_index]
    @pop_index = inc_index(@pop_index)
    output
  end

  private

  def inc_index(index)
    index += 1
    index = 0 if index > (@elements.size - 1)
    index
  end

  def dec_index(index)
    index -= 1
    index = (@elements.size -1) if index < 0
    index
  end
end
