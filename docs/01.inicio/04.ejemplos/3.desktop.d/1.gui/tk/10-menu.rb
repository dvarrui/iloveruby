#!/usr/bin/env ruby

require "tk"

root = TkRoot.new
root.title = "Window"


menu_click = Proc.new {
   Tk.messageBox(
      'type'    => "ok",
      'icon'    => "info",
      'title'   => "Title",
      'message' => "Message"
   )
}

file_menu = TkMenu.new(root)

file_menu.add('command',
              'label'     => "New...",
              'command'   => menu_click,
              'underline' => 0)
file_menu.add('command',
              'label'     => "Open...",
              'command'   => menu_click,
              'underline' => 0)
file_menu.add('command',
              'label'     => "Close",
              'command'   => menu_click,
              'underline' => 0)
file_menu.add('separator')
file_menu.add('command',
              'label'     => "Save",
              'command'   => menu_click,
              'underline' => 0)
file_menu.add('command',
              'label'     => "Save As...",
              'command'   => menu_click,
              'underline' => 5)
file_menu.add('separator')
file_menu.add('command',
              'label'     => "Exit",
              'command'   => menu_click,
              'underline' => 3)

menu_bar = TkMenu.new
menu_bar.add('cascade',
             'menu'  => file_menu,
             'label' => "File")

root.menu(menu_bar)

Tk.mainloop
