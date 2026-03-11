#!/usr/bin/env ruby

require 'colorize'
require 'pry-byebug'
require 'test/unit'

extend Test::Unit::Assertions

class CommandDu
  attr_reader :datas

  def initialize(command)
    @command = command
    @datas = fill_this_array
  end

  def show
    @datas.each do |data|
      text =  "#{data[:name]}\t#{data[:size]}"
      if data[:ismax]
        puts text.colorize(:light_yellow)
      else
        puts text.white
      end
    end
  end

  private

  def execute_command()
    output = `#{@command}`.chomp
    output.split("\n")
  end

  def mark_datas_when_ismax(max)
    @datas.each do |item|
      number = item[:number]
      item[:ismax] = true if number == max
    end
  end

  def new_data(name:, size:, number:)
    { name: name, size: size, number: number, ismax: false,}
  end

  def fill_this_array()
    max = 0
    @datas = []

    lines = execute_command
    lines.each do |line|
      items = line.split()

      name = items[1]
      size = items[0]
      number = size.to_f
      max = number if number > max

      @datas += [ new_data(name: name, size: size, number:number) ]
    end
    mark_datas_when_ismax(max)
  end

end

# assert datas.size == 3, "data.size == 3?"
# binding.pry
du = CommandDu.new('du -sh *')
du.show
