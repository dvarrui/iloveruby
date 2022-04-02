#!/usr/bin/env ruby

DISTRO='debian'

system 'apt update'
packages = [ 'vim', 'nano', 'tree', 'nmap', 'git', 'figlet' ]

for name in packages 
  system "zypper install -y #{name}"
end

system "figlet #{DISTRO} > /etc/motd"

echos = [ "'' >> /etc/motd", 
          "'David Vargas Ruiz' >> /etc/motd",
          "'https://github.com/dvarrui' >> /etc/motd",
          "'# Adding more alias' >> /home/vagrant/.bashrc",
          "\"alias c='clear'\" >> /home/vagrant/.bashrc",
          "\"alias v='vdir'\" >> /home/vagrant/.bashrc" ]

for line in echos
  system "echo #{line}"
end

system 'lsb_release -d'
