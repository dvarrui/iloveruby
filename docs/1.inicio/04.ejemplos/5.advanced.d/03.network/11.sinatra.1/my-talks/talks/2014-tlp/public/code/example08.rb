#!/usr/bin/ruby
# encoding: utf-8

require 'gosu'
require 'yaml'

class GameWindow < Gosu::Window
	def initialize
		super( 800, 600, false)
		self.caption = File.basename($0)
		
		@config = YAML::load(File.open("example08.yaml"))
		@background = Gosu::Image.new(self, @config[:background_image], true)
		@actors=[]
		@config[:enemies].each { |c| @actors << Enemy.new(self, c) }

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

class Enemy
	def initialize(window,config)
		@window=window
		@image = Gosu::Image.new(@window, config[:image], true)
		
		@pos_x=config[:posx] || 0.0
		@pos_y=config[:posy] || 0.0
		@vel_x=config[:velx] || 0.0
		@vel_y=config[:vely] || 0.0
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
		@image.draw_rot(@pos_x, @pos_y, 10, 0)
	end
end

window = GameWindow.new
window.show

