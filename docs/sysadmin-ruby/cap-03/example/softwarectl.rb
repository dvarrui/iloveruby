#!/usr/bin/env ruby

##
# Install OS packages
def install_packages
  system("zypper install -y tree")
  system("zypper install -y nmap")
  system("zypper install -y vim")
end

install_packages
