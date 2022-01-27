
require_relative '../adventure'

class Item
  attr_accessor :name
  attr_accessor :states
  attr_accessor :state_id
  attr_accessor :room
  attr_accessor :actions
  attr_accessor :collected

  def initialize(id, args = {})
    @name = id
    @states = args[:states] if args[:states]
    @state_id = 0
    @room = args[:room] if args[:room]
    @actions = []
    @taken = false
  end

  def show
    puts @states[@state_id]
  end

  def collected?
    @collected
  end
end
