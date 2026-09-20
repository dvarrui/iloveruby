#!/usr/bin/env ruby

module Log
  TYPE = "INFO"
  def info(message)
    puts "#{Time.now} [#{TYPE}] #{message}"
  end
end

class Demo4
  extend Log
end

###
# d = Demo4.new
# d.info("Método de instancia")
# undefined method (NoMethodError)

Demo4.info("Método de clase")
