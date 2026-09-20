#!/usr/bin/env ruby

require "tk"

button = TkButton.new {
   text 'Hello World!'
   pack
}
button.configure('activebackground', 'blue')
Tk.mainloop
