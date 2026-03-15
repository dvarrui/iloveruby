#!/bin/bash

# $author: Cristian S. Glez Torres
# $date: 7/7/2013
# $description: Script de instalacion de puppet

# El = no puede tener espacios en las siguientes variables

MASTERNAME="master"
MASTERIP="172.16.9.118"
CLIENTNAME="client"
CLIENTIP="172.16.9.218"
DOMAINHOSTS="jedy"
COMPROBACION=`id -u`

DIRAUX="aux"
ALUNAME="Cristian S. Glez. Torres"


function show_help()
	{

		echo "#########################################################################"
		echo "# --help:           Muestra la ayuda                                    #"
		echo "# --master-install: Instala el puppet master en la maquina configurado  #"
		echo "# --master-accept:  El host master acepta el intercambio de certificado #"
		echo "# --client-install: Instala el puppet cliente en la maquina configurado #"
		echo "# --client-test:    verifica la conexion de los equipos                 #"
		echo "#########################################################################"

	}


function install_master()

		{

			echo $MASTERNAME > /etc/hostname

			echo domain $DOMAINHOSTS >> /etc/resolv.conf 

			echo search $DOMAINHOSTS >> /etc/resolv.conf

			echo "127.0.0.1 localhost" >> /etc/hosts
			
			echo 127.0.0.1 $MASTERNAME.$DOMAINHOSTS $MASTERNAME >> /etc/hosts

			echo $MASTERIP $MASTERNAME.$DOMAINHOSTS $MASTERNAME >> /etc/hosts

			echo $CLIENTIP $CLIENTNAME.$DOMAINHOSTS $CLIENTNAME >> /etc/hosts

 			apt-get install puppetmaster
			
			mkdir /etc/puppet/files

			mkdir /etc/puppet/manifests

			mkdir /etc/puppet/manifests/classes

			mv DIRAUX/site.pp /etc/puppet/manifests

			mv DIRAUX/jedy.pp /etc/puppet/manifests 

			/etc/init.d/puppetmaster restart
 
			}

function master_accept()

		{

		puppetca --sign $CLIENTNAME.$DOMAINHOSTS

		puppetca --list
		puppetca --print $CLIENTNAME.$DOMAINHOSTS

		} 


function install_client()
	{

		
				echo $CLIENTNAME > /etc/hostname

				echo domain $DOMAINHOSTS >> /etc/resolv.conf
				
				echo search $DOMAINHOSTS >> /etc/resolv.conf


				echo "127.0.0.1 localhost" >> /etc/hosts

				echo 127.0.1.1 $CLIENTNAME.$DOMAINHOSTS $CLIENTNAME >> /etc/hosts
				
				echo $CLIENTIP $CLIENTNAME.$DOMAINHOSTS $CLIENTNAME >> /etc/hosts

				echo $MASTERIP $MASTERNAME.$DOMAINHOSTS $MASTERNAME >> /etc/hosts

				

				apt-get install puppet


				echo server=$MASTERNAME.$DOMAINHOSTS >> /etc/puppet/puppet.conf


				sed -i  "s/START=.*/START=yes/" /etc/default/puppet


				/etc/init.d/puppet restart


exit
}
 


function test_client()
{
		puppet agent --server $MASTERNAME.$DOMAINHOSTS --test
}


if  [ $COMPROBACION = "0" ]

then
		if [ "$1" == "" ]
			
			then
				echo "vea la ayuda con ./install.sh --help"
			else
				case "$1" in

					--help)

						show_help;;

					--master-install)

						install_master;;
						
					--master-accept)

						master_accept;;

					--client-install)

						install_client;;

					--client-test)

						test_client;;
				esac
		fi
else
	echo "No tiene privilegios ROOT"
fi

