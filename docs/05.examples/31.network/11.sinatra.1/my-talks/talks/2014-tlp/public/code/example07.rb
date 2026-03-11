#!/usr/bin/ruby
# encoding: utf-8

=begin
* Estado de los actores
* Transiciones suaves
=end

require 'gosu'

class GameWindow < Gosu::Window
	def initialize
		super( 800, 600, false)
		self.caption = "example07"
		
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
		
		@angle=0.0
		@ang_vel=0.0

		@pos_x=@window.width/2
		@pos_y=@window.height/2
		@vel_x=40.0
		@vel_y=40.0
		@size_x=@image.width/2
		@size_y=@image.height/2

		@state=:move_x
		@next_y=nil
	end
	
	def update(timestep)
		if @state==:move_x then
			@pos_x = @pos_x + @vel_x * timestep
			if (@pos_x-@size_x)<0 || (@pos_x+@size_x)>@window.width then
				@vel_x = @vel_x * -1
				@state=:move_y
				@next_y=@pos_y+@size_y*2
			end
		elsif @state==:move_y then
			if @pos_y<@next_y then
				@pos_y = @pos_y + @vel_y * timestep
			else
				@state=:move_x
			end
		end
		if (@pos_y-@size_y)<0 || (@pos_y+@size_y)>@window.height then
			@window.close
		end
	end
	
	def draw
		@image.draw_rot(@pos_x, @pos_y, 10, @angle)
	end
end

window = GameWindow.new
window.show
