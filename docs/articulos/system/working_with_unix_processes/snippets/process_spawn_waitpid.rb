# Do it the blocking way
system 'sleep 5'

# Do it the non-blocking way
Process.spawn 'sleep 5'

# Do it the blocking way with Process.spawn
# Notice that it returns the pid of the child process
pid = Process.spawn 'sleep 5'
Process.waitpid(pid)

