
require_relative 'pipenable'

class MyInteger
  attr_reader :pipevalue
  include Pipenable

  def initialize(value)
    @pipevalue = value
    @pipelog = nil

    @pipeout = :myself
    @pipein = :add
    @pipedebug = true
  end

  def myself
    self
  end

  def +(obj)
    new_obj = MyInteger.new(@pipevalue + obj.pipevalue)
    new_obj
  end

  def add(obj)
    new_obj = MyInteger.new(@pipevalue + obj.pipevalue)
    new_obj
  end

end
