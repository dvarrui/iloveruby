#!/usr/bin/ruby
# encoding: utf-8

require 'gosu'

class GameWindow < Gosu::Window
	def initialize
		super( 800, 600, false)
		self.caption = "example06"
		
		 @background = Gosu::Image.new(self, "assets/space.png", true)
	end

	def update
	end
	
	def draw
		@background.draw(0, 0, 0)
	end
	
	 def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

window = GameWindow.new
window.show
