#!/usr/bin/ruby
#File: install_puppet.rb

=begin

    Cambiar nombre de máquina: echo "client1" > /etc/hostname
    Modificar /etc/resolv.conf y poner al comienzo:

domain nombregrupo
search nombregrupo
...

    Añadir a /etc/hosts

127.0.0.1 localhost
127.0.1.1 client1.nombregrupo client1
IP-master master.nombregrupo master
IP-client1 client1.nombregrupo client1
...


Instalación:

    Añadir a /etc/puppet/puppet.conf:

[main]
server=master.nombregrupo
...

    Editar el archivo /etc/default/puppet, y modificar la línea

...
#start puppet on boot
START=yes
...

    Reiniciar servicio: /etc/init.d/puppet restart
    Comprobamos los log: tail /var/log/syslog
=end

require 'yaml'

@debug=true

def install_puppet(psOption)
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
		
	r = IO.popen("cat /etc/group | grep italc |wc -l").readlines
	if r[0].to_i==0 then
		execute("addgroup italc")
	end

	users=YAML::load(File.open("users.yaml"))		
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
	puts "\n[INFO] Configuring PUPPET Server..."
	raise 'Write the code!'	
end

def install_client
	puts "\n[INFO] Configuring PUPPET Client..."
	
	r = IO.popen("dpkg -l puppet | grep 'ii' |wc -l").readlines
	if r[0].to_i==0 then
		execute("apt-get install -y puppet")
	end

	execute("mv /etc/italc/keys/public/teacher/key /etc/italc/keys/public/teacher/key.000")		
	execute("cp ./italc-teacher.key /etc/italc/keys/public/teacher/key ")
	execute("cd /etc/italc; chgrp italc -R keys")
	
	install_common
end

def execute(lsCommand)
	puts "(*) Executing: #{lsCommand}"
	system(lsCommand) if !@debug
end

install_italc (ARGV.first||'none')

