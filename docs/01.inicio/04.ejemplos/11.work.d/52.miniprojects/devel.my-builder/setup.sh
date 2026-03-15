#!/bin/bash
#./setup.sh

function show_help() {
	echo '--help     : Muestra esta ayuda'
	echo '--debian   : Prepara un sistema Debian para la instalación.'
	echo '--opensuse : Prepara un sistema OpenSuse para la instalación'
	echo '--ubuntu   : Prepara un sistema Ubuntu para la instalación'
}

function setup_debian() {
	apt-get update
	apt-get install -y ruby chpasswd
	mkdir tmp
}

function setup_opensuse() {
	zypper refresh
	zypper install -d ruby chpasswd
	mkdir tmp
}

function setup_ubuntu() {
	apt-get update
	apt-get install -y ruby1.9.1
	mkdir tmp
}

case $1 in
'--help')
	show_help
	exit 0
	;;
'--debian')
	setup_debian;;
'--opensuse')
	setup_opensuse;;
'--ubuntu')
	setup_ubuntu;;
*)
	echo "USE: $0 --help"
	exit 1
	;;	
esac

chmod +x run

echo "Ahora ejecutar el constructor:"
echo "  ./run"
