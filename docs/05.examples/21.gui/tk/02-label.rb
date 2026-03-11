#!/usr/bin/env ruby
require 'tk'

top = TkRoot.new {title "Label and Entry Widget"}

# code to add a label widget
lb1 = TkLabel.new(top) {
   text 'Hello World'
   background "green"
   foreground "white"
   pack('padx'=>10, 'pady'=>10, 'side'=>'left')
}

# code to add a entry widget
e1 = TkEntry.new(top) {
   background "blue"
   foreground "white"
   pack('padx'=>10, 'pady'=>10, 'side'=>'left')
}

Tk.mainloop

