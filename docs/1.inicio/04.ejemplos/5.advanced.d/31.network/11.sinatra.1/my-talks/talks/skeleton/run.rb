#!/usr/bin/ruby
# encoding: utf-8

require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra/base'
require_relative 'map'

class Talk < Sinatra::Base
	set :static, true
  set :public_folder, 'public'
  #set :bind, '192.168.1.104'
  #set :port, 1616
	
	get '/code/:filename' do
		send_file File.join(settings.root,settings.public_folder,"code",params[:filename]), :type=>'text/plain', :disposition => 'inline'
	end

	get '/download/code/:filename' do
		send_file File.join(settings.root,settings.public_folder,"code",params[:filename])
	end

	get '/images/:filename' do
		send_file File.join(settings.root,settings.public_folder,"images",params[:filename]), :type=>'image/png', :disposition => 'inline'
	end

	get '/' do
		@head=get_head('index')
		erb :index
	end

	get '/index' do
		@head=get_head('index')
		erb :index
	end

	get '/:dirname/:filename' do
		pageid="#{params[:dirname]}/#{params[:filename]}"
		@head = get_head pageid
		erb pageid.to_sym
	end
	
	
	def get_head(pageid='index')
		start_time=Time.local(2014,"jul",18,13,0)
		now_time=Time.now
		
	
		@map = Map.new(File.dirname($0)+"/views")
		s=""
		s+="<b>TLP-2014</b> | "
		s+="<a href='/index'>&Iacute;ndice</a> ("+@map.head(pageid)+") | "
		if @map.previous(pageid) then 
			s+="<a href='/"+@map.previous(pageid)+"'>Anterior</a>"
		else
			s+="Anterior"
		end		 
		s+=" | "
		if @map.next(pageid) then
			s+="<a href='/"+@map.next(pageid)+"'>Siguiente</a>"
		else
			s+="Siguiente"
		end
		s+="  ("+((now_time-start_time)/60).to_i.to_s+" min.)"
		s+="</br><hr>"
	end
	
	def get_file(filename)
		c=File.new(filename).readlines
		s="<pre>"
		c.each { |l| s+=l.to_s }
		s+="</pre>"
	end
	
end

Talk.run!
