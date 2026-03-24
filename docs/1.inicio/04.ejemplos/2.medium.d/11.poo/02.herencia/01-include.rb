#!/usr/bin/env ruby

module Log
  def info(message)
    puts "#{Time.now} [INFO] #{message}"
  end
end

class Demo1
  include Log
end

d = Demo1.new
d.info("Método de instancia")

###
# Demo1.info("Método de clase")
# undefined method `info' for Demo1:Class (NoMethodError)
