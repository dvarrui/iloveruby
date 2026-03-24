#!/usr/bin/ruby
# encoding: utf-8

require 'gosu'
require 'yaml'

class GameWindow < Gosu::Window
	
	def initialize
		super( 800, 600, false)
		self.caption = File.basename($0)
		
		@config = YAML::load(File.open("example10.yaml"))
		@background = Gosu::Image.new(self, @config[:background_image], true)
		@actors=[]
		@config[:enemies].each { |c| @actors << Enemy.new(self, c) }
		@player=Player.new(self, @config[:player])
		@bullet=Bullet.new(self, @config[:bullet], @player, @actors)
		@font = Gosu::Font.new(self, "assets/edunline.ttf", 20)

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
		
		@font.draw("Use keys left, right and space", 10, 15, 99, 1.0, 1.0, 0xff00ffff)
		@font.draw("SCORE "+@player.score.to_s, 10, height-25, 99, 1.0, 1.0, 0xff00ffff)
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
	attr_accessor :enable
	
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
		@enable=true
	end
	
	def update(timestep)
		return if !@enable

		case @state
		when :move_x			
			@pos_x = @pos_x + @vel_x * timestep
			if (@pos_x-@size_x)<0 || (@pos_x+@size_x)>@window.width then
				@vel_x = @vel_x * -1
				@state=:move_y
				@next_y=@pos_y+@size_y*2
			end
		when :move_y
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
		if @enable then
			@image.draw_rot(@pos_x, @pos_y, 10, 0)
		end
	end
			
	def x1; @pos_x-@size_x; end
	def x2; @pos_x+@size_x; end
	def y1; @pos_y-@size_y; end
	def y2; @pos_y+@size_y; end	
	
end

class Player
	attr_reader :pos_x, :pos_y, :size_x, :size_y
	attr_accessor :score
	
	def initialize(window,config)
		@window=window
		@image = Gosu::Image.new(@window, config[:image], true)
		
		@score=0

		@pos_x=config[:posx] || 0.0
		@pos_y=config[:posy] || 0.0
		@speed=config[:speed]
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
	
	def initialize(window, config, player, enemies)
		@window=window
		@player=player
		@enemies=enemies
		@image = Gosu::Image.new(@window, config[:image], true)
		@beep =  Gosu::Sample.new(@window, "assets/beep.wav" )
		@explosion =  Gosu::Sample.new(@window, "assets/explosion.wav" )
		
		@pos_x= 0.0
		@pos_y= 0.0
		@speed=config[:speed]
		@size_x=@image.width/2
		@size_y=@image.height/2
		@state=:stop		

	end
		
	def update(timestep)
		@enemies.each do |e|
			if e.enable and collides_with?(e) then
				e.enable=false
				@state=:stop
				@player.score+=1
			end
		end
		
		case @state
		when :fire
			@pos_x=@player.pos_x
			@pos_y=@player.pos_y-@player.size_y
			@beep.play
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
	
	def collides_with?(other)
		if x1<other.x2 && x2>other.x1 && y1<other.y2 && y2>other.y1 then
			@state=:stop
			@explosion.play
			return true
		end
		return false
	end

	def x1; @pos_x-@size_x; end
	def x2; @pos_x+@size_x; end
	def y1; @pos_y-@size_y; end
	def y2; @pos_y+@size_y; end	
	
end

window = GameWindow.new
window.show

