# Set the maximum number of open files to 3. We know this
# will be maxed out because the standard streams occupy
# the first three file descriptors.
Process.setrlimit(:NOFILE, 3)

File.open('/dev/null')

