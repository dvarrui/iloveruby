#!/usr/bin/env ruby

require 'colorize'
require 'pry-byebug'
require 'test/unit' 

extend Test::Unit::Assertions

def get_from_system()
  datas = []
  output = `du -sh *`.chomp
  lines = output.split("\n")

  lines.each do |line|
    items = line.split()
    datas += [ { name: items[1], 
                 size: items[0], 
		 number: items[0].to_f
	     } ]
  end

  datas
end

def select_max_from(datas)
  max = datas[0]
  len = datas.size - 1

  (1..len).to_a.each do |i| 
    if datas[i][:number] > max[:number]
      max = datas[i]
    end
  end
  
  max
end

def show(datas:, max:)
  datas.each do |data|
    text =  "#{data[:name]}\t#{data[:size]}"
    if data[:name] == max[:name]
      puts text.light_yellow
    else
      puts text.white
    end
  end
end

datas = get_from_system
assert datas.size == 14

max = select_max_from datas
show(datas: datas, max: max)

