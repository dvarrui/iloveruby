#!/usr/bin/ruby
# encoding: utf-8
#File: install_italc.rb

require 'yaml'

def install_italc(psOption)
	@dirbase=File.dirname($0)+"/.."

	# Read project main config file
	config=YAML::load( File.open(File.join(@dirbase,"config.yaml")) )	
	@room=config[:room] || 'room'

	# Put users into italc group
	@users=YAML::load( File.open(File.join(@dirbase,"users.yaml")) )		
	
	if psOption=='slave' then
		install_slave
	elsif psOption=='master' then
		install_master
	else
		puts "[ERROR] Option <#{psOption}> unknown! (Try: master or slave)"
	end
end

def install_common
	puts "\n[INFO] Configuring ITALC Common..."
	
	# Add italc group
	r = `cat /etc/group | grep italc |wc -l`
	execute("addgroup italc") if r.to_i==0

	@users.each do |item|
		r = `cat /etc/group | grep italc |grep #{item[:name]} |wc -l`
		if r.to_i==0 and item[:italc_user] then
			execute("usermod #{item[:name]} --groups italc")
		end

		# Add lines into user's profile file
		filename="#{item[:home]}/.profile"

		if File.exists?(filename) and item[:italc_user] then
			lsTexto="exec /usr/bin/ica &"
			
			r = `cat #{filename} | grep \"#{lsTexto}\" |wc -l`
			if r.to_i==0 and item[:italc_user] then
				execute("echo \"# Added automaticaly by script: install_italc.rb\" >> #{filename}")
				execute("echo \"#{lsTexto}\" >> #{filename}")
			end
			execute("chown root #{filename}")
			execute("chmod 644 #{filename}")
		elsif item[:italc_user] then
			puts("[ERROR] Could't find profile for <#{item[:name]}> user")
		else
			puts("[INFO] Didn't change profile for <#{item[:name]}> user")
		end
	end

	execute("cd /etc/italc; chgrp italc -R keys")	
end
 
def install_master
	puts "\n[INFO] Configuring ITALC Master..."	

	r = `dpkg -l italc-master | grep 'ii' |wc -l`
	execute("apt-get install -y italc-master") if r.to_i==0
		
	execute("ica -createkeypair") if !File.exists? "/etc/italc/keys/public/teacher/key"
	execute("cp /etc/italc/keys/public/teacher/key #{@dirbase}/files.d/italc.d/#{@room}-master-teacher.key")

	@users.each do |item|
		if item[:italc_user] then
			italcdir = "#{item[:home]}/.italc"
			if !File.directory?(italcdir) then
				execute("mkdir #{italcdir}")
				execute("cp #{@dirbase}/files.d/italc.d/#{@room}-globalconfig.xml #{italcdir}/globalconfig.xml")
				execute("cp #{@dirbase}/files.d/italc.d/#{@room}-personalconfig.xml #{italcdir}/personalconfig.xml")
				execute("chmod 755 #{italcdir}")
				execute("chown -R #{item[:name]}.#{item[:name]} #{italcdir}")
			end
		end
	end
	
	install_common
end

def install_slave
	puts "\n[INFO] Configuring ITALC Slave..."
	
	r = `dpkg -l italc-master | grep 'ii' |wc -l`
	execute("apt-get purge -y italc-master") if r.to_i>0
	
	r = `dpkg -l italc-client | grep 'ii' |wc -l`
	execute("apt-get install -y italc-client") if r.to_i==0
	
	execute("ica -createkeypair")	if !File.directory? "/etc/italc/keys/public/teacher"

	if File.exists? "/etc/italc/keys/public/teacher/key" then
		execute("mv /etc/italc/keys/public/teacher/key /etc/italc/keys/public/teacher/key.bak")
	end
	
	execute("cp #{@dirbase}/files/italc.d/#{@room}-master-teacher.key /etc/italc/keys/public/teacher/key ")
	install_common
end

def execute(lsCommand)
	puts "(*) Executing: #{lsCommand}"
	flag=system(lsCommand) if !@debug
end

@debug=false
install_italc (ARGV.first||'none')
