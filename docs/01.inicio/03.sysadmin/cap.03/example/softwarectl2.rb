#!/usr/bin/env ruby

# Package names list
packages = [ 'tree', 'nmap', 'vim', 'geany' ]

##
# Install OS packages
def install(packages)
  packages.each do |package|
    system("zypper install -y #{package}")
  end
end

##
# Remove OS packages
def remove(packages)
  packages.each do |package|
    system("zypper remove -y #{package}")
  end
end

##
# Choose action from input argument
if ARGV.first == '--install'
  install(packages)
elsif ARGV.first == '--remove'
  remove(packages)
else
  puts "Usage: #{$0} [--install|--remove]"
  puts ""
  puts "Options: "
  puts "         --install, install packages"
  puts "         --remove, remove packages"
  exit 1
end
