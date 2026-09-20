#!/usr/bin/env ruby
# Create and delete user defined into FILENAME

require 'colorize'
require_relative 'lib-userctl6'

def check_arguments
  # Check input arguments
  if ARGV.empty? or ARGV.size < 2
    puts "Usage:   #{$0} FILENAME"
    puts "         FILENAME is a text file with a list of user names."
    puts "\nWarning: Run this script as superuser."
    exit 1
  end
  # Check input file exist
  unless File.exist?(ARGV[1])
    puts "[ERROR] File \'#{ARGV.first}\' dosn\'t exist!".light_red
    exit 1
  end
  return action, ARGV[1]
end

def read_input_data(filename)
  data = []
  # Read input file => Array with file content
  inputs = File.read(filename).split("\n")

  # Remove lines that start with # character
  lines = inputs.select { |i| !i.start_with?("#") )
  lines.each do |line|
    items = line.split(':')
    user = {}
    user[:action] = item[0]
    user[:name] = item[1]
    user[:password] = item[2] || item[1]
    user[:home] = item[3] || "/home/#{item[1]}"
    user[:shell] = item[4] || '/bin/bash'
    data << user
  end
  data
end

def process_users(data)
  data.each do |user|
    create_user(user) if user[:action] == 'create'
    delete_user(user) if user[:action] == 'delete'
  end
end

filename = check_arguments
process_users(read_input_data(filename))
