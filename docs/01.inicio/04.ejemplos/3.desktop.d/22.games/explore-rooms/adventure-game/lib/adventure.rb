
require 'singleton'
require 'rainbow'
require_relative 'adventure/room'
require_relative 'adventure/actor'
require_relative 'adventure/item'

class Adventure
  include Singleton
  attr_accessor :rooms
  attr_accessor :player
  attr_accessor :items

  def initialize
    @rooms = {}
    @actors = {}
    @items = {}
  end

  def start
    create
    play
  end

  def add_room(id, args)
    @rooms[id] = Room.new(id, args)
  end

  def add_player(args)
    @player = Actor.new('player', args)
  end

  def add_item(id, args)
    @items[id] = Item.new(id, args)
  end

  def get_room(id)
    @rooms[id]
  end

  def get_actor(id)
    @actors[id]
  end

  def get_item(id)
    @items[id]
  end

  def is_action(action, param)
    return true if @action == action && @param == param
    false
  end

private

  def play
    # show_intro
    puts Rainbow(intro).silver
    print Rainbow("(Pulsa enter para continuar)").aqua
    $stdin.gets.strip
    show_game
    while(true)
      global_logic
      logic
    end
  end

  def show_game
    @player.room.show
    @player.items
    puts "\n"
  end

  def get_input
    print Rainbow("=> ").aqua
    @input = $stdin.gets.strip
    @inputs = @input.split(' ')
    @action = @inputs[0]
    @param = @inputs[1]
  end

  def global_logic
    get_input
    if @action.nil?
      show_game
      return
    elsif @action == 'help'
      puts "\nAcciones disponibles: "
      puts "  - quit      # Salir del programa"
      puts "  - help      # Mostrar esta ayuda"
      puts "  - go   DIR  # Avanzar por DIRECTION"
      puts "  - take ITEM # Coger objeto"
      puts "  - drop ITEM # Dejar objeto"
      puts "  - use ITEM  # Usar objeto"
      return
    elsif @action == 'quit'
      puts "\n¡Adios!"
      exit
    elsif @action == 'take'
      return @player.take(@param)
    elsif @action == 'drop'
      return @player.drop(@param)
    elsif @action == 'items'
      return @player.items
    end
    param = @action
    param = @param if @action == 'go'
    if @player.go(param)
      show_game
    end
  end
end
