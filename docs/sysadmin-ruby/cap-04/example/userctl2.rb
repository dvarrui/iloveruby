#!/usr/bin/env ruby
# Create and delete user defined into FILENAME
require 'colorize'

##
# Check input arguments
def check_arguments
  # Check input arguments
  if ARGV.empty? or ARGV.size < 2
    puts "Usage:   #{$0} [-c|-d] FILENAME"
    puts "\nOptions:"
    puts "         -c, Create users"
    puts "         -d, Delete users"
    puts "         FILENAME is a text file with a list of user names."
    puts "\nWarning: Run this script as superuser."
    exit 1
  end
  if %w[-c --create].include? ARGV[0]
    action = :create
  elsif %w[-d --delete].include? ARGV[0]
    action = :delete
  else
    puts "Exec: #{$0}"
    exit 1
  end
  # Check input file exist
  unless File.exist?(ARGV[1])
    puts "[ERROR] File \'#{ARGV.first}\' dosn\'t exist!".light_red
    exit 1
  end
  return action, ARGV[1]
end

##
# Create users from filename
def create_users(filename)
  # Read input file
  users = %x[cat #{filename}].split("\n")
  # Create users
  # * Create user 'name'
  # * Create home folder as '/home/name'
  # * Set user password to '123456'
  users.each do |name|
    ok = system("useradd #{name} -m -p 123456")
    unless ok
      puts "[ERROR] User '#{name}' no created!".light_red
    end
  end
end

##
# Delete users from filename
def delete_users(filename)
  # Read input file
  users = %x[cat #{filename}].split("\n")
  # Delete users
  # -f => forces the removal of the user account,
  #       even if the user is still logged in.
  # -r => Files in the user's home directory will be removed
  #       along with the home directory itself and the user's mail spool.
  users.each do |name|
    ok = system("userdel -rf #{name}")
    unless ok
      puts "[ERROR] User '#{name}' no deleted!".light_red
    end
  end
end

action, filename = check_arguments
create_users(filename) if action == :create
delete_users(filename) if action == :delete
