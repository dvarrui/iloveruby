#!/usr/bin/env ruby

require "glimmer-dsl-libui"
require "debug"

class Data
  attr_accessor :text
  def initialize
    @text = "change me"
  end

  def load(filepath)
    @text = File.read(filepath)
  end
end

class App
  include Glimmer::LibUI::Application

  before_body do
    @data = Data.new
  end

  body {
    window('Notepad', 500, 300) {
      vertical_box {
        padded true

        horizontal_box {
          stretchy false

          button("Open") {
            on_clicked do
              filepath = open_file
              @data.text = File.read(filepath)
            end
          }

          button("New") {
            on_clicked do
              @data.text = ""
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

          button("Exit") {
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
