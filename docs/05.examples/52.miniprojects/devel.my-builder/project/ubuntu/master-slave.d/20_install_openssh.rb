#!/usr/bin/ruby
# encoding: utf-8
#File: install_openssh.rb

require 'yaml'

def install_openssh(psOption)
	@dirbase=File.join(File.dirname($0), "..")

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
	r = `dpkg -l openssh-server | grep 'ii' |wc -l`
	if r.to_i==0 then
		execute("apt-get install -y openssh-server")
	else
		puts "[INFO] Package <openssh-server> already installed!"
	end
end

def install_master
	puts "\n[INFO] Configuring OpenSSH Master..."
	install_common
	
	@users.each do |item|
		if item[:ssh_user] then
			puts "[INFO] Openssh processing <#{item[:name]}> user"
			filetarget = File.join( item[:home], ".ssh", "id_rsa.pub")
			filedest=File.join( @dirbase, "files.d","openssh.d", "#{@room}-master-#{item[:name]}-id_rsa.pub")
			
			execute("sudo -u #{ item[:name] } ssh-keygen -q") if !File.exists? filetarget 
			execute("cp #{filetarget} #{filedest}")
		end
	end
	# Copy file sshd_config to project: PermitRootLogin?
	filedest=File.join( @dirbase, "files.d","openssh.d", "#{@room}-sshd_config")
	execute("cp /etc/ssh/sshd_config #{filedest}")
	
	r = `cat #{filedest} |grep \"AllowUsers\" |wc -l`
	if r.to_i==0 then
		execute("echo \"# Project tt-builder\" >> #{filedest}")
		execute("echo \"AllowUsers super root\" >> #{filedest}")
	end
end

def install_slave
	puts "\n[INFO] Configuring OpenSSH Client..."
	install_common
	
	@users.each do |item|
		if item[:ssh_user] then
			sshdir=File.join( item[:home], ".ssh" )
			puts "[INFO] Openssh processing <#{item[:name]}> user (#{sshdir})"

			if !File.directory? sshdir then
				execute("mkdir #{sshdir}")
				execute("chmod 644 #{sshdir}")
				execute("chown #{item[:name]}.#{item[:name]} #{sshdir}")	
			end
	
			filetarget = File.join( @dirbase,"files.d","openssh.d","#{@room}-master-#{item[:name]}-id_rsa.pub")
			filedest = File.join( sshdir, "authorized_keys")
			
			if File.exists? filetarget then
				execute("cp #{filetarget} #{filedest}")
				execute("chmod 644 #{filedest}")
				execute("chown #{item[:name]}.#{item[:name]} #{filedest}")
			else
				puts "[WARN] File <#{filetarget}> not found!"
			end
		end
	end
	# Ccopy file sshd_config from project
	filedest=File.join( @dirbase, "files.d","openssh.d", "#{@room}-sshd_config")
	execute("cp #{filedest} /etc/ssh/sshd_config")
	
end

def execute(lsCommand)
	puts "[EXEC] #{lsCommand}"
	flag=system(lsCommand) if !@debug
end

@debug=false
install_openssh (ARGV.first||'none')
