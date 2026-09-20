#!/usr/bin/env ruby
require "gtk4"

application = Gtk::Application.new("org.gtk.example", :flags_none)

application.signal_connect "activate" do |app|
  # Create a new window and set its title
  win = Gtk::ApplicationWindow.new(app)
  win.title = "Packing"

  # Here we construct the container that is going to pack our buttons.
  grid = Gtk::Grid.new

  # Pack the container in the window
  win.set_child(grid)

  button = Gtk::Button.new(label: "Button 1")
  button.signal_connect("clicked") { puts "Hello World!" }

  # Place the first button in the grid cell (0, 0), and make it fill
  # just 1 cell horizontally and vertically (ie no spanning)
  grid.attach(button, 0, 0, 1, 1)

  button = Gtk::Button.new(label: "Button 2")
  button.signal_connect("clicked") { puts "Hello World!" }

  # Place the second button in the grid cell (1, 0), and make it fill
  # just 1 cell horizontally and vertically (ie no spanning)
  grid.attach(button, 1, 0, 1, 1)

  button = Gtk::Button.new(label: "Quit")
  button.signal_connect("clicked") { win.destroy }

  # Place the Quit button in the grid cell (0, 1), and make it
  # span 2 columns.
  grid.attach(button, 0, 1, 2, 1)

  win.show
end

application.run
