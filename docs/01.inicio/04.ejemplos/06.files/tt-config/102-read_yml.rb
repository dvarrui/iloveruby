#!/usr/bin/env ruby
require 'debug'
require 'tty-config'

config = TTY::Config.new
config.filename = "investments"

# To read an investments.yml file, you need to provide the locations to search in:
config.append_path Dir.pwd
config.append_path Dir.home

# Finally, call read to convert configuration file back into an object again:
config.read

puts config.to_h
puts config.to_h.to_yaml
