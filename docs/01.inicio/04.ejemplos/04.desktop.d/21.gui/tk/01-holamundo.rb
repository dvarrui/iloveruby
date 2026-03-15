#!/usr/bin/env ruby
require "tk"

root = TkRoot.new { title "holamundo" }
TkLabel.new(root) {
  text  "Hola, Mundo!"
  pack  { padx 15 ; pady 15; side "left" }
}
Tk.mainloop

