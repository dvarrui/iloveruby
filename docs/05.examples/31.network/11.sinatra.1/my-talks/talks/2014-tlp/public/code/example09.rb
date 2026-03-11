#!/usr/bin/ruby
# encoding: utf-8

require 'gosu'
require 'yaml'

class GameWindow < Gosu::Window
	def initialize
		super( 800, 600, false)
		self.caption = File.basename($0)
		
		@config = YAML::load(File.open("example09.yaml"))
		@background = Gosu::Image.new(self, @config[:background_image], true)
		@actors=[]
		@config[:enemies].each { |c| @actors << Enemy.new(self, c) }
		@player=Player.new(self, @config[:player])
		@bullet=Bullet.new(self, @config[:bullet], @player)
		
		@timestamp=Time.now
	end

	def update
		now=Time.now
		@timestep=now-@timestamp
		@actors.each { |a| a.update(@timestep) }
		@player.update @timestep
		@bullet.update @timestep
		@timestamp=now
	end
	
	def draw
		@background.draw(0, 0, 0)
		@actors.each { |a| a.draw }
		@player.draw
		@bullet.draw
	end
	
	def button_down(id)
		case id
		when Gosu::KbEscape
      close
    when Gosu::KbLeft
			@player.left
    when Gosu::KbRight
			@player.right
    when Gosu::KbSpace
			@bullet.fire
		end
  end
  
  def button_up(id)
		@player.stop
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

class Player
	attr_reader :pos_x, :pos_y, :size_x, :size_y
	
	def initialize(window,config)
		@window=window
		@image = Gosu::Image.new(@window, config[:image], true)
		
		@pos_x=config[:posx] || 0.0
		@pos_y=config[:posy] || 0.0
		@speed=config[:speed] || 0.0
		@size_x=@image.width/2
		@size_y=@image.height/2
		stop
	end
	
	def update(timestep)
		case @state
		when :left
			@pos_x=@pos_x-@speed*timestep
			@pos_x=@size_x if (@pos_x-@size_x)<0
		when :right
			@pos_x=@pos_x+@speed*timestep
			@pos_x=@window.width-@size_x if (@pos_x+@size_x)>@window.width
		end
	end
	
	def draw
		@image.draw_rot(@pos_x, @pos_y, 10, 0)
	end
	
	def left
		@state=:left
	end

	def right
		@state=:right
	end
	
	def stop
		@state=:stop
	end	
end

class Bullet	
	def initialize(window, config, player)
		@window=window
		@player=player
		@image = Gosu::Image.new(@window, config[:image], true)
		
		@pos_x= 0.0
		@pos_y= 0.0
		@speed=config[:speed]
		@size_x=@image.width/2
		@size_y=@image.height/2
		stop
	end
		
	def update(timestep)
		case @state
		when :fire
			@pos_x=@player.pos_x; @pos_y=@player.pos_y-@player.size_y
			@state=:move
		when :move
			@pos_y=@pos_y+@speed*timestep
			if @pos_y<0 then
				@state=:stop 
			end
		end
	end
	
	def draw
		if @state==:move then
			@image.draw_rot(@pos_x, @pos_y, 20, 0)
		end
	end
	
	def fire
		if @state==:stop then
			@state=:fire
		end
	end
	
	def stop
		@state=:stop
	end
	
end

window = GameWindow.new
window.show

