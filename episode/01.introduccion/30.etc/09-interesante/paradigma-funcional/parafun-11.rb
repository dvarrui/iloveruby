#!/usr/bin/env ruby

class Character
  attr_reader :name, :type

  def initialize(params)
    @name = params[:name]
    @type = params[:type]
  end

  def show
    puts "My name is #{@name}, and I'm a #{@type}."
  end
end

obiwan = Character.new( name: 'Obiwan', type: 'jedi')
maul = Character.new(name: 'Maul', type: 'sith')

obiwan.show
maul.show
