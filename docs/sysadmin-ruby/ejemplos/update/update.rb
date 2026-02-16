#!/usr/bin/env ruby

commands = [ 'sudo zypper refresh', 'sudo zypper update' ]

for cmd in commands 
  puts " => #{cmd} "
  system cmd
end
