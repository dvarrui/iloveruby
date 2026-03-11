
require 'colorize'

class Actor
  attr_writer :talk
  attr_reader :name

  def initialize(name, color)
    @name = name.upcase
    @color = color
  end

  def say(text)
    puts "[#{@name}] #{text}".colorize(@color)
    @talk.add_sentence(@name, @text)
  end
end
