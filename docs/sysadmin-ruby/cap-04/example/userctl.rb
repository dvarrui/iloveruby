#!/usr/bin/env ruby
require 'colorize'

def check_arguments
  # Check input arguments
  if ARGV.empty?
    puts "Usage: #{$0} FILENAME"
    puts "       FILENAME is a text file with a list of user names."
    exit 1
  end
  # Check input file exist
  unless File.exist?(ARGV.first)
    puts "[ERROR] File \'#{ARGV.first}\' dosn\'t exist!".light_red
    exit 1
  end
end

def create_users(filename)
  # Check current user
  unless %x[whoami].chop == 'root'
    puts "[ERROR] Run as \'root\' user!".light_red
    exit 1
  end
  # Read input file
  users = %x[cat #{filename}].split("\n")
  # Create users
  users.each do |name|
    ok = system("useradd #{name} -m -p 123456")
    unless ok
      puts "[ERROR] User '#{name}' not created!".light_red
    end
  end
end

check_arguments
create_users(ARGV.first)
