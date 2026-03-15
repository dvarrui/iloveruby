#!/usr/bin/env ruby
# https://www.devdungeon.com/content/get-password-console-ruby

require 'io/console'

puts "[INFO] Accept password and print return"
# The prompt is optional
password = IO::console.getpass "Enter Password: "
sleep 5
puts "Your password was #{password.length} characters long."
