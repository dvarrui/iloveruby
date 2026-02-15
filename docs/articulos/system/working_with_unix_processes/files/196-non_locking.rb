#!/usr/bin/env ruby

# Do it the blocking way
puts "[1/3] system blocking"
system 'sleep 5'

# Do it the non-blocking way
puts "[2/3] spawn non blocking"
Process.spawn 'sleep 5'

# Do it the blocking way with Process.spawn
# Notice that it returns the pid of the child process
puts "[3/3] waiting process"
pid = Process.spawn 'sleep 5'
Process.waitpid(pid)
