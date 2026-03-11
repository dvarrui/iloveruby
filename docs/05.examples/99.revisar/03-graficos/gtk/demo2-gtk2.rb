#!/usr/bin/ruby

# ZetCode Ruby GTK tutorial
#
# In this program, we position two buttons
# in the bottom right corner of the window.
# We use horizontal and vertical boxes.
#
# author: jan bodnar
# website: www.zetcode.com
# last modified: June 2009

require 'gtk2'

class RubyApp < Gtk::Window
  def initialize
    super
    set_title "Buttons"
    signal_connect "destroy" do
      Gtk.main_quit
    end
    init_ui

    set_default_size 260, 150
    set_window_position Gtk::Window::POS_CENTER
    show_all
  end

  def init_ui
    vbox = Gtk::VBox.new false, 5
    hbox = Gtk::HBox.new true, 3        
    valign = Gtk::Alignment.new 0, 1, 0, 0
    vbox.pack_start valign

    ok = Gtk::Button.new "OK"
    ok.set_size_request 70, 30
    close = Gtk::Button.new "Close"
    hbox.add ok
    hbox.add close

    halign = Gtk::Alignment.new 1, 0, 0, 0
    halign.add hbox

    vbox.pack_start halign, false, false, 3
    add vbox
  end
end

Gtk.init
window = RubyApp.new
Gtk.main
