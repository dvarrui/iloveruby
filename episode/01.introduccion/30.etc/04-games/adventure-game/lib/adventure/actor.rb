
require_relative '../adventure'

class Actor
  attr_accessor :name

  def initialize(id, args = {})
    @name = id
    @current_room_id = args[:room] if args[:room]
  end

  def room
    Adventure.instance.rooms[@current_room_id]
  end

  def go(param)
    target_room_id = room.doors[param]
    if target_room_id.nil?
      puts "¡No entiendo la orden!\n"
      return false
    end
    if Adventure.instance.rooms[target_room_id].nil?
      puts "[ERROR] Revisa la definición de la habitación #{@current_room_id}!"
      return false
    end
    @current_room_id = target_room_id
    true
  end

  def take(id)
    item = Adventure.instance.items[id]
    if item.nil?
      puts "El objeto #{id} no existe!"
      return
    elsif not item.room == @current_room_id
      puts "No puedes hacer eso!"
      return
    end
    item.collected = true
    item.room = ''
  end

  def drop(id)
    item = Adventure.instance.items[id]
    if item.nil?
      puts "El objeto #{id} no existe!"
      return
    elsif not item.collected?
      puts "No puedes hacer eso!"
      return
    end
    item.collected = false
    item.room = @current_room_id
  end

  def items
    list = Adventure.instance.items.values.select { |i| i.collected? }
    return if list.size.zero?
    print "Inventario: "
    puts list.map(&:name).join(', ')
  end
end
