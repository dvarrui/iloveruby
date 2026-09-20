#!/usr/bin/env ruby
username = %x[whoami].chop
puts "You are #{username}."
