#!/usr/bin/env ruby
# Create and delete user defined into FILENAME
require 'colorize'

def create_user(user)
  create_user_on_linux(user) if OS.linux?
  create_user_on_windows(user) if OS.windows?
end

def create_user_on_linux(user)
  ok = system("useradd #{user[:name]} -m -d #{user[:home]} -p #{user[:password]}")
  unless ok
    puts "[ERROR] User '#{user[:name]}' no created!".light_red
  end
end

def create_user_on_windows(user)
  ok = system("net user #{user[:name]} #{user[:password]} /ADD")
  unless ok
    puts "[ERROR] User '#{user[:name]}' no created!".light_red
  end
end

def delete_user(user)
  delete_user_on_linux(user) if OS.linux?
  delete_user_on_windows(user) if OS.windows?
end

def delete_user_on_linux(user)
  ok = system("userdel -rf #{user[:name]}")
  unless ok
    puts "[ERROR] User '#{user[:name]}' no deleted!".light_red
  end
end

def delete_user_on_windows(user)
  ok = system("net user #{user[:name]} /DELETE")
  unless ok
    puts "[ERROR] User '#{user[:name]}' no created!".light_red
  end
end
