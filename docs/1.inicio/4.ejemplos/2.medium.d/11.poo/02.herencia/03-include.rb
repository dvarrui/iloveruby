#!/usr/bin/env ruby

module Log
  TYPE = "INFO"

  def info(message)
    puts "#{Time.now} [#{TYPE}] #{message}"
  end
end

class Demo3
  include Log
end

d = Demo3.new
d.info("Método de instancia")

###
# Demo3.info("Método de clase")
# undefined method (NoMethodError)
