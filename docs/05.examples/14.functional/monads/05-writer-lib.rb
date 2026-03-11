
class Writer
  attr_reader :value, :log

  def initialize(value, log = "New")
    @value = value
    if value.is_a? Proc
      @log = log
    else
      @log = log + ": " + @value.to_s 
    end
  end

  def self.unit(value, log)
    Writer.new(value, log)
  end

  def bind(mwriter)
    proc = mwriter.value 
    log = mwriter.log
    new_value = proc.call(@value)
    new_log = @log + "\n" + log
    self.class.new(new_value, new_log)
  end
end

