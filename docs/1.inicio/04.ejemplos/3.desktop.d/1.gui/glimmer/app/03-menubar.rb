#!/usr/bin/env ruby
require 'glimmer-dsl-libui'
require "debug"

class Window3
  include Glimmer
  attr_accessor :filepath
  attr_accessor :content

  def initialize
    @title = "03-menubar"
    @filepath = ""
    @content = ""
  end

  def init
    create_menubar
    create_window(self, @title, 300, 30)
  end

  def create_window(app, title, w, h)
    @win_object = window(title, w, h) {
      margined true

      vertical_box {
        form {
          stretchy false
          @entry_filepath = entry {
            label 'Filepath'
            text <=> [app, :filepath]
          }
          @entry_content = entry {
            label 'Content'
            text <=> [app, :content]
          }
        }
      }
    }
  end

  def create_menubar
    menu("File") {
      menu_item("Open") {
        on_clicked do
          @filepath = open_file
          puts @filepath
        end
      }

      menu_item("Save") {
        on_clicked do
          puts "[DEBUG] savefile"
        end
      }

      quit_menu_item {
        on_clicked do
          puts "Bye Bye"
        end
      }
    }

    menu("Help") {
      menu_item("About") {
        on_clicked do
          message_box("Thanks you for using!", "https://rubygems.org/gems/")
        end
      }
    }
  end

  def show
    # @entry_name.text = @name
    # @entry_tags.text = @tags
    @win_object.show
  end

end

w = Window3.new
w.init
w.show
