
require 'rainbow'
require_relative '../adventure'

class Room
  attr_accessor :id
  attr_accessor :name
  attr_accessor :desc
  attr_accessor :doors

  def initialize(id, args = {})
    @id = id
    @desc = args[:desc] if args[:desc]
    @doors = args[:doors] if args[:doors]
  end

  def items
    Adventure.instance.items.values.select { |i| i.room == @id }
  end

  def show
    puts "\n"
    puts Rainbow(@desc).silver
    items.each { |i| i.show }
    return if @doors.nil?

    puts "Puedes ir a:"
    @doors.each_key { |key| puts " - #{key}"}
  end
end
