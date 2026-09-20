#!/usr/bin/ruby
#File: install_virtualbox.rb

FLAG=`cat /etc/apt/sources.list |grep virtualbox.org | wc -l`

if FLAG.to_i==0 then
	#Add this repo to the sources file
	FILE="/etc/apt/sources.list"
	system("echo \"#VirtualBox-4.3\" >> #{FILE}")
	system("echo \"deb http://download.virtualbox.org/virtualbox/debian trusty contrib\" >> #{FILE}")
	#Download the key file from VirtualBox site
	system("wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -")
end

system("apt-get update")
system("apt-get install -y virtualbox-4.3")
system("apt-get install -y dkms")

system("/etc/init.d/vboxdrv setup")

