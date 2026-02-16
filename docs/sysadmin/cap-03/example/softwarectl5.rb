#!/usr/bin/env ruby
require 'colorize'

def check_arguments
  # Check input arguments
  if ARGV.empty?
    puts "Usage: #{$0} FILENAME"
    puts "       FILENAME is a text file with a list of package names."
    exit 1
  end
  # Check input file exist
  unless File.exist?(ARGV.first)
    puts "[ERROR] File \'#{ARGV.first}\' dosn\'t exist!".light_red
    exit 1
  end
end

def install_packages(filename)
  # Check current user
  unless %x[whoami].chop == 'root'
    puts "[ERROR] Run as \'root\' user!".light_red
    exit 1
  end
  # Read input file
  packages = %x[cat #{filename}].split("\n")
  # Install packages
  packages.each do |package|
    ok = system("zypper install -y #{package}")
    unless ok
      puts "[ERROR] Package '#{package}' not installed!".light_red
    end
  end
end

check_arguments
install_packages(ARGV.first)
