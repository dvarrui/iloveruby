#!/bin/bash
#File: install_virtualbox.sh

FLAG=`cat /etc/apt/sources.list |grep virtualbox.org | wc -l`

if [ $FLAG -eq 0 ]; then
	#Add this repo to the sources file
	FILE=/etc/apt/sources.list
	echo "#VirtualBox" >> $FILE
	echo "deb http://download.virtualbox.org/virtualbox/debian precise contrib" >> $FILE
	#Download the key file from VirtualBox site
	wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
fi

apt-get update
apt-get install -y virtualbox-4.2
apt-get install -y dkms

usermod super --groups vboxusers
usermod asir --groups vboxusers
usermod daw --groups vboxusers

/etc/init.d/vboxdrv setup
