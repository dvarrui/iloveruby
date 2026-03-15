
require_relative 'actor'

class Talk
  attr_accessor :sentences
  attr_reader :actors

  def initialize
    @sentences = []
    @actors = {}
  end

  def add_sentence(actor, message)
    record =  Struct.new(:timestamp, :actor, :message)
    @sentences << record.new(Time.now, actor, message)
  end

  def add_actor(name, color=:default)
    actor = Actor.new(name, color)
    actor.talk = self
    @actors[name] = actor
    actor
  end
end
