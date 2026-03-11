#!/usr/bin/env ruby

require 'colorize'
require 'pry-byebug'
require 'test/unit'

extend Test::Unit::Assertions

def execute_command()
  output = `du -sh *`.chomp
  output.split("\n")
end

def mark_datas_when_ismax(datas:, max:)
  datas.each do |item|
    number = item[:number]
    item[:ismax] = true if number == max
  end
  datas
end

def new_data(name:, size:, number:)
  { name: name, size: size, number: number, ismax: false,}
end

def get_datas()
  max = 0
  datas = []

  lines = execute_command
  lines.each do |line|
    items = line.split()

    name = items[1]
    size = items[0]
    number = size.to_f
    max = number if number > max

    datas += [ new_data(name: name, size: size, number:number) ]
  end
  mark_datas_when_ismax(datas: datas, max: max)
end

def show(datas)
  datas.each do |data|
    text =  "#{data[:name]}\t#{data[:size]}"
    if data[:ismax]
      puts text.colorize(:light_yellow).blink
    else
      puts text.white
    end
  end
end

datas = get_datas
# assert datas.size == 3, "data.size == 3?"
show(datas)
