#!/usr/bin/ruby
# encoding: utf-8

=begin
* Estado de los actores
=end

require 'gosu'

class GameWindow < Gosu::Window
	def initialize
		super( 800, 600, false)
		self.caption = "example06"
		
		@background = Gosu::Image.new(self, "assets/space.png", true)
		@actor = Enemy.new(self)
		
		@timestamp=Time.now
	end

	def update
		now=Time.now
		@actor.update(now-@timestamp)
		@timestamp=now
	end
	
	def draw
		@background.draw(0, 0, 0)
		@actor.draw
	end
	
	 def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

class Enemy
	def initialize(window)
		@window=window
		@image = Gosu::Image.new(@window, "assets/enemy1.png", true)
		@x=@window.width/2
		@y=@window.height/2
		@a=0.0
		@speed_x=40.0
		@speed_y=30.0
		@speed_a=20.0
		@size_x=@image.width/2
		@size_y=@image.height/2
	end
	
	def update(timestep)
		@x = @x + @speed_x * timestep
		if (@x-@size_x)<0 || (@x+@size_x)>@window.width then
			@speed_x = @speed_x * -1
			@y = @y + @size_y
		end 
		if (@y-@size_y)<0 || (@y+@size_y)>@window.height then
			@window.close
		end 
	end
	
	def draw
		@image.draw_rot(@x, @y, 10, @a)
	end
end

window = GameWindow.new
window.show
