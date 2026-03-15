#!/usr/bin/env ruby

module Log
  def info(message)
    puts "#{Time.now} [INFO] #{message}"
  end
end

class Demo2
  extend Log
end

###
# d = Demo2.new
# d.info("Método de instancia")
# undefined method `info' for #<Demo2:0x00007efc96e7c068> (NoMethodError)

Demo2.info("Método de clase")
