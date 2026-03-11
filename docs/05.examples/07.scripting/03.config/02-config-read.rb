#!/usr/bin/env ruby

require "tty-config"

config = TTY::Config.new
puts config.read("config.yaml")
