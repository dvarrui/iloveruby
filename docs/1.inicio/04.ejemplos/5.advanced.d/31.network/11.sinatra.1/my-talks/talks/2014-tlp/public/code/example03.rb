#!/usr/bin/ruby
# encoding: utf-8

=begin
* Using external configuration files
* More Actors (Game Objects)
=end

require 'gosu'
require 'yaml'

class GameWindow < Gosu::Window
	def initialize
		super( 800, 600, false)
		self.caption = "example03"
		
		@config = YAML::load(File.open("example03.yaml"))
		@background = Gosu::Image.new(self, @config[:background_image], true)
		@actors=[]
		@config[:tuercas].each { |c| @actors << Tuerca.new(self, c) }

		@timestamp=Time.now
	end

	def update
		now=Time.now
		@actors.each { |a| a.update(now-@timestamp) }
		@timestamp=now
	end
	
	def draw
		@background.draw(0, 0, 0)
		@actors.each { |a| a.draw }
	end
	
	 def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end

class Tuerca	
	def initialize(window,config)
		@window=window
		@image = Gosu::Image.new(@window, config[:image], true)
		
		@angle=0.0
		@ang_vel=config[:ang_vel]

		@pos_x=config[:posx] || 0.0
		@pos_y=config[:posy] || 0.0
		@vel_x=config[:velx] || 0.0
		@vel_y=config[:vely] || 0.0
		@size_x=@image.width/2
		@size_y=@image.height/2
	end
	
	def update(timestep)
		@pos_x = @pos_x + @vel_x * timestep
		@pos_y = @pos_y + @vel_y * timestep
		@angle = @angle + @ang_vel * timestep
		if (@pos_x-@size_x)<0 || (@pos_x+@size_x)>@window.width then
			@vel_x = @vel_x * -1
			@ang_vel = @ang_vel * -1
		end 
		if (@pos_y-@size_y)<0 || (@pos_y+@size_y)>@window.height then
			@vel_y = @vel_y * -1
			@ang_vel = @ang_vel * -1
		end 
	end
	
	def draw
		@image.draw_rot(@pos_x, @pos_y, 10, @angle)
	end
end

window = GameWindow.new
window.show
