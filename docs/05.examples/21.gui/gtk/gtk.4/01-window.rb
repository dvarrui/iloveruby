#!/usr/bin/env ruby
require "gtk4"

application = Gtk::Application.new("org.gtk.example", :flags_none)

application.signal_connect "activate" do |app|
  window = Gtk::ApplicationWindow.new(app)
  window.title = "Window"
  window.set_default_size(200, 200)
  window.show
end

application.run
