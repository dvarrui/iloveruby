#!/usr/bin/env ruby
require "gtk4"

application = Gtk::Application.new("org.gtk.example", :flags_none)

application.signal_connect "activate" do |app|
  window = Gtk::ApplicationWindow.new(app)
  window.title = "Hello World"
  window.set_default_size(200, 200)

  button_box = Gtk::Box.new(:horizontal)
  button_box.halign = :center
  button_box.valign = :center
  window.set_child(button_box)

  button = Gtk::Button.new(label: "Hello World")

  button.signal_connect "clicked" do
    puts "Hello World"
    window.destroy
  end
  button_box.append(button)

  window.show
end

application.run
