#!/usr/bin/env ruby
#

#require 'io-console'
require 'io/console'

c = IO.console # =>  #<File:/dev/tty>
# IO.console(sym, *args)
c.clear_screen
c.beep
system('vdir /home/david')
c.cursor_up 4
