#!/usr/bin/env ruby

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

lam_sqrt = ->(number) { Math.sqrt(number) }
lam_add_one = ->(number) { number + 1 }
lam_half = ->(number) { number / 2.0 }

sqrt = Writer.unit( lam_sqrt, "Took square root")
add_one = Writer.unit( lam_add_one, "Added one")
half = Writer.unit( lam_half, "Divided by 2")

m1 = Writer.unit(5, "Initial value")
m2 = m1.bind(sqrt).bind(add_one).bind(half)

puts "The Golden Ratio is #{m2.value}"
puts "\nThis was derived as follows:"
puts m2.log

