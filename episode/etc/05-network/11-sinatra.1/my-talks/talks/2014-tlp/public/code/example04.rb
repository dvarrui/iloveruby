#!/usr/bin/ruby
# encoding: utf-8

=begin
* Player (Game Object)
* Input Manager
* Sound Manager
=end

require 'gosu'
require 'yaml'

class GameWindow < Gosu::Window
	def initialize
		super( 800, 600, false)
		self.caption = File.basename($0)
		
		@config = YAML::load(File.open("example04.yaml"))
		@background = Gosu::Image.new(self, @config[:background_image], true)
		@actors=[]
		@config[:tuercas].each { |c| @actors << Tuerca.new(self, c) }
		@player=Tornillo.new(self, @config[:tornillo])

		@timestamp=Time.now
	end

	def update
		now=Time.now
		timestep=now-@timestamp
		
		@actors.each { |a| a.update(timestep) }
		@player.update timestep
		
		@timestamp=now
	end
	
	def draw
		@background.draw(0, 0, 0)
		@actors.each { |a| a.draw }
		@player.draw
	end
	
	def button_down(id)
		case id
		when Gosu::KbEscape
      close
    when Gosu::KbUp
			@player.move
    when Gosu::KbLeft
			@player.left
    when Gosu::KbRight
			@player.right
		end
  end

	def button_up(id)
    @player.stop
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
		
		@beep =  Gosu::Sample.new(@window, "assets/beep.wav" )
	end
	
	def update(timestep)
		@pos_x = @pos_x + @vel_x * timestep
		@pos_y = @pos_y + @vel_y * timestep
		@angle = @angle + @ang_vel * timestep
		if (@pos_x-@size_x)<0 || (@pos_x+@size_x)>@window.width then
			@beep.play
			@vel_x = @vel_x * -1
			@ang_vel = @ang_vel * -1
		end 
		if (@pos_y-@size_y)<0 || (@pos_y+@size_y)>@window.height then
			@beep.play
			@vel_y = @vel_y * -1
			@ang_vel = @ang_vel * -1
		end 
	end
	
	def draw
		@image.draw_rot(@pos_x, @pos_y, 10, @angle)
	end
end

class Tornillo	
	def initialize(window,config)
		@window=window
		@image = Gosu::Image.new(@window, config[:image], true)
		
		@angle=config[:angle]
		@ang_vel=config[:ang_vel]
		@pos_x=config[:posx] || 0.0
		@pos_y=config[:posy] || 0.0
		@speed=config[:speed] || 0.0
		@size_x=@image.width/2
		@size_y=@image.height/2
	end
	
	def update(timestep)
		case @state
		when :move
			vel_x = Gosu::offset_x(@angle, @speed)
			vel_y = Gosu::offset_y(@angle, @speed)
			@pos_x = @pos_x + vel_x * timestep
			@pos_y = @pos_y + vel_y * timestep
			if (@pos_x)<0 || (@pos_x)>@window.width || \
				(@pos_y)<0 || (@pos_y)>@window.height then
				@pos_x = @window.width/2
				@pos_y = @window.height/2
			end
		when :left
			@angle = @angle - @ang_vel * timestep
		when :right
			@angle = @angle + @ang_vel * timestep
		else
			@state=:stop
		end
	end
	
	def draw
		@image.draw_rot(@pos_x, @pos_y, 10, @angle)
	end
	
	def left
		@state=:left
	end
	
	def right
		@state=:right
	end
	
	def move
		@state=:move
	end
	
	def stop
		@state=:stop
	end
end

window = GameWindow.new
window.show
