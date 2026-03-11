#!/usr/bin/env ruby

require 'tk'

root = TkRoot.new
root.title = "Window"

msgBox = Tk.messageBox (
   'type'    => "ok",
   'icon'    => "info", 
   'title'   => "This is title",
   'message' => "This is message"
)
Tk.mainloop
