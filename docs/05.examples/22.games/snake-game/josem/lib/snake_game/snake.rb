require 'set'

class Snake < Array
  SYMBOL = 'O'

  def crashed?
    visited = Set.new

    self.each_with_index do |position, i|
      if visited.include?(position)
        return true
      else
        visited << position
      end
    end

    return false
  end
end