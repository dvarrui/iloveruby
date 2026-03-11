#!/usr/bin/env ruby

require "glimmer-dsl-libui"
require "debug"

class Data
  attr_accessor :text
  def initialize
    @text = "change me"
  end

  def self.load(filepath)
    File.read(filepath)
  end

  def self.new_input
    <<-TEXT
  version 1
  lang en
  context CHANGE, ME
    TEXT
  end

  def self.concept_add
    <<-TEXT

  concept #---------------------------------------------------------
    names CHANGE
    tag   CHANGE, ME
    def   CHANGE
    TEXT
  end

  def self.concept_close
    <<-TEXT
  end
    TEXT
  end

  def self.table_add
    <<-TEXT
    table  #----------------------------
      fields CHANGE, ME
      row    CHANGE, ME
      row    CHANGE, ME
    end
    TEXT
  end
end

class GuiData
  attr_accessor :title, :w, :h
  def initialize
    @title = "Notepad 6"
    @w = 700
    @h = 700
  end
end

class App
  include Glimmer::LibUI::Application

  before_body do
    @gui = GuiData.new
    @data = Data.new

    menu("Exit") {
      quit_menu_item {}
    }
  end

  body {

    window(@gui.title, @gui.w, @gui.h) {

      vertical_box {
        padded true

        horizontal_box {
          stretchy false

          button("Open") {
            on_clicked do
              filepath = open_file
              @data.text = Data.load(filepath)
            end
          }

          button("New input") {
            on_clicked do
              @data.text = Data.new_input
            end
          }

          button("Concept add") {
            on_clicked do
              @data.text += Data.concept_add
            end
          }

          button("Table add") {
            on_clicked do
              @data.text += Data.table_add
            end
          }

          button("Concept close") {
            on_clicked do
              @data.text += Data.concept_close
            end
          }

          button("Check") {
            on_clicked do
              if @data.text.empty?
                msg_box('Empty!', 'Please enter some text first.')
              else
                puts "[DEBUG] #{@data.text.length}"
              end
            end
          }

          button("Execute") {
            on_clicked do
              exit 0
            end
          }
        }

        multiline_entry {
          text <=> [@data, :text]
          on_changed {
            puts "[multiline] changed"
          }
        }
      }
    }
  }
end

App.launch
