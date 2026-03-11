#!/usr/bin/env ruby
require 'tty-spinner'

spinner = TTY::Spinner.new("[:spinner] Loading ...", format: :classic)

spinner.auto_spin # Automatic animation with default interval
sleep(4) # Perform task

# spinner.stop("Done!") # Stop animation
spinner.success
