# The maximum number of simultaneous processes 
# allowed for the current user.
Process.getrlimit(:NPROC)

# The largest size file that may be created.
Process.getrlimit(:FSIZE)

# The maximum size of the stack segment of the
# process.
Process.getrlimit(:STACK)


