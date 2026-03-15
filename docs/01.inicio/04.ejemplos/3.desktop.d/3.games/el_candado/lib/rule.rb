
require_relative 'apply'

class Rule
  def initialize(combination:, included:, in_position:)
    @combination = combination
    @included = included
    @in_position = in_position
  end

  def check(other)
    comparation = Apply.evaluate(@combination, other)
    return false unless comparation[:included] == @included
    return false unless comparation[:in_position] == @in_position
    true
  end
end
