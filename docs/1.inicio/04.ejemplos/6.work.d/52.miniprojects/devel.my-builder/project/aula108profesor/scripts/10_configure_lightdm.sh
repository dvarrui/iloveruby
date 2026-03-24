#!/bin/bash
#File: configure_lightdm.sh

FLAG=`cat /etc/lightdm/lightdm.conf |grep greeter-hide-users | wc -l`

if [ $FLAG -eq 0 ]; then
	#Introduce lines into the config file to hide the users list
	FILE=/etc/lightdm/lightdm.conf
	echo "greeter-hide-users=true" >> $FILE
	echo "allow-guest=false" >> $FILE
fi
