
class Writer
  attr_reader :value, :log

  def initialize(value, log = "New")
    @value = value
    if log.is_a? Array
      @log = log
    elsif value.is_a? Proc 
      @log = [ log ]
    else
      @log = [ msg(log, @value) ]
    end
  end

  def self.unit(value, log)
    Writer.new(value, log)
  end

  def bind(mwriter)
    proc = mwriter.value 
    log = mwriter.log.first
    new_value = proc.call(@value)
    new_log = @log << msg(log, new_value)
    # new_log = @log << "#{log} : #{new_value}"
    self.class.new(new_value, new_log.flatten)
  end

  def to_s
    "Writer value:#{@value}, log=#{log.to_s}"
  end

  private

  def msg(log, value)
    "#{log.rjust(18)} => #{value.to_s}"
  end

end

