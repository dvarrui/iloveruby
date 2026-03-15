#!/usr/bin/env ruby

require "dotenv/load"

puts "MY_VAR   = #{ENV["MY_VAR"]}"
puts "my_var   = #{ENV["my_var"]}"
puts "HOSTNAME = #{ENV["HOSTNAME"]}"

