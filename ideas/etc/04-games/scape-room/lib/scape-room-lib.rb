#!/usr/bin/env ruby
require 'pry-byebug'

class Game
  attr_accessor :rooms

  def initialize
    @rooms = {}
    @next = :main
    @current = :main
  end

  def start
    puts "Iniciando el juego"
    while @next != :exit
      puts ''
      current = @next
      if @rooms[current].nil?
        puts "[ERROR] Estado #{current} no definido"
        exit 1
      end
      block = @rooms[current]
      instance_eval(&block)
      sleep 1
    end
    puts "Fin del juego"
  end

  def next_state(state)
    @next = state
  end

  def wait_user(inputs = {})
    option = ''
    actions = inputs.keys
    while not actions.include? option do
      puts ""
      inputs.each_pair { |key,value| puts("(#{key}) #{value}") }
      print "¿Qué eliges? "
      option = gets.chomp
    end
    sleep 1
    option
  end

  def wait_seg(number)
    number.to_i.times do
      print '.'
      sleep 1
    end
    print "\n"
  end
end

@game = Game.new

def room(name, &block)
  @game.rooms[name] = block
end
