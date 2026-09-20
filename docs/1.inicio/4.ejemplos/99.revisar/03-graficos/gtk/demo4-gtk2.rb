#!/usr/bin/ruby

# ZetCode Ruby GTK tutorial
#
# This is a more complicated layout example.
# We use Alignment and Table widgets.
#
# author: jan bodnar
# website: www.zetcode.com
# last modified: June 2009

# sudo zypper install gtk2-devel
# gem install gtk2
require 'gtk2'

class RubyApp < Gtk::Window
  def initialize
    super
    set_title "Windows"
    signal_connect "destroy" do
      Gtk.main_quit
    end
    init_ui

    set_default_size 300, 250
    set_window_position Gtk::Window::POS_CENTER
    show_all
  end

  def init_ui
    set_border_width 15
    table = Gtk::Table.new 8, 4, false
    table.set_column_spacings 3
    title = Gtk::Label.new "Windows"
    halign = Gtk::Alignment.new 0, 0, 0, 0
    halign.add title
    table.attach(halign, 0, 1, 0, 1, Gtk::FILL, Gtk::FILL, 0, 0)

    frame = Gtk::Frame.new
    table.attach(frame, 0, 2, 1, 3, Gtk::FILL | Gtk::EXPAND,
        Gtk::FILL | Gtk::EXPAND, 1, 1)

    activate = Gtk::Button.new "Activate"
    activate.set_size_request 50, 30
    table.attach(activate, 3, 4, 1, 2, Gtk::FILL,
          Gtk::SHRINK, 1, 1)

    valign = Gtk::Alignment.new 0, 0, 0, 0
    close = Gtk::Button.new "Close"
    close.set_size_request 70, 30
    valign.add close
    table.set_row_spacing 1, 3
    table.attach(valign, 3, 4, 2, 3, Gtk::FILL,
        Gtk::FILL | Gtk::EXPAND, 1, 1)

    halign2 = Gtk::Alignment.new 0, 1, 0, 0
    help = Gtk::Button.new "Help"
    help.set_size_request 70, 30
    halign2.add help
    table.set_row_spacing 3, 6
    table.attach(halign2, 0, 1, 4, 5, Gtk::FILL,
        Gtk::FILL, 0, 0)

    ok = Gtk::Button.new "OK"
    ok.set_size_request 70, 30
    table.attach(ok, 3, 4, 4, 5, Gtk::FILL,
        Gtk::FILL, 0, 0)

    add table
  end
end

Gtk.init
window = RubyApp.new
Gtk.main
