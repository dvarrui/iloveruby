#!/usr/bin/env ruby
require 'fox16'
require_relative "window"

application = FXApp.new("Asker", "FoxTest")
AskerWindow.new(application)
application.create
application.run
