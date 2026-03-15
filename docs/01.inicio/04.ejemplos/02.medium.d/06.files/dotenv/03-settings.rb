#!/usr/bin/env ruby

require "dotenv/load"

class Settings
  def self.method_missing(method_name, *args)
    ENV[method_name.to_s]
  end
end

puts "MY_VAR   = #{Settings.MY_VAR}"
puts "my_var   = #{Settings.my_var}"
puts "HOSTNAME = #{Settings.HOSTNAME}"

