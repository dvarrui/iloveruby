#!/usr/bin/ruby
#File: install_italc.rb

require 'yaml'

@debug=false
@usersfile="config/aula108/users.yaml"		
@keyfile="config/aula108/files/italc-teacher.key"

def install_italc(psOption)
	if psOption=='client' then
		install_client
	elsif psOption=='master' then
		install_master
	else
		puts "[ERROR] Option <#{psOption}> unknown! (Try: client or master)"
	end
end

def install_common
	puts "\n[INFO] Configuring ITALC Common..."
	
	#Addgroup
	r = IO.popen("cat /etc/group | grep italc |wc -l").readlines
	if r[0].to_i==0 then
		execute("addgroup italc")
	end

	#Mod every user
	users=YAML::load(File.open(@usersfile))		
	users.each do |item|
		r = IO.popen("cat /etc/group | grep italc |grep #{item[:name]} |wc -l").readlines
		if r[0].to_i==0 and item[:name]!='root' then
			execute("usermod #{item[:name]} --groups italc")
		end

		lsTexto="exec /usr/bin/ica &"
		r = IO.popen("cat #{item[:home]}/.profile | grep \"#{lsTexto}\" |wc -l").readlines
		if r[0].to_i==0 and item[:name]!='root' then
			execute("echo \"#Add by script call: install_italc.rb\" >> #{item[:home]}/.profile")
			execute("echo \"#{lsTexto}\" >> #{item[:home]}/.profile")
		end
		
		execute("chown root #{item[:home]}/.profile")
		
	end	
end

def install_master
	puts "\n[INFO] Configuring ITALC Server..."
	
	r = IO.popen("dpkg -l italc-master | grep 'ii' |wc -l").readlines
	if r[0].to_i==0 then
		execute("apt-get install -y italc-master")
	end
		
	if !File.exists? "/etc/italc/keys/public/teacher/key" then
		execute("ica -createkeypair")
		execute("cp /etc/italc/keys/public/teacher/key ./italc-teacher.key")
	end
	
	install_common
end

def install_client
	puts "\n[INFO] Configuring ITALC Client..."
	
	r = IO.popen("dpkg -l italc-client | grep 'ii' |wc -l").readlines
	if r[0].to_i==0 then
		execute("apt-get install -y italc-client")
	end

	execute("mv /etc/italc/keys/public/teacher/key /etc/italc/keys/public/teacher/key.000")		
	execute("cp #{@keyfile} /etc/italc/keys/public/teacher/key ")
	execute("cd /etc/italc; chgrp italc -R keys")
	
	install_common
end

def execute(lsCommand)
	puts "(*) Executing: #{lsCommand}"
	system(lsCommand) if !@debug
end

install_italc (ARGV.first||'none')
