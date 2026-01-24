Process.setrlimit(:NOFILE, 4096)
p Process.getrlimit(:NOFILE)

