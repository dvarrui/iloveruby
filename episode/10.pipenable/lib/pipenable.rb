
require 'pry-byebug'

module Pipenable
  attr_accessor :pipein, :pipeout

  def pipe(obj)
    pin = obj.pipein
    pout = self.pipeout
    value = self.send(pout)
    new_obj = obj.send(pin, value)
    # msg = "#{obj.pipevalue}.#{obj.pipein}(#{self.pipelog})"
    msg = "#{obj.pipein}(#{obj.pipevalue},#{self.pipelog})"
    new_obj.pipelog(msg)
    new_obj
  end

  def pipelog(log = :get)
    if log == :get
      return @pipelog if @pipelog
      return @pipevalue
    end
    @pipelog = log
  end

  def to_s
    text = "[ VALUE ] #{@pipevalue}"
    if @pipedebug
      text = "[ DEBUG ] #{@pipelog} \n" + text
    end
    text
  end

end
