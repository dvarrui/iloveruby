passwd = File.open('/etc/passwd')
puts passwd.fileno
passwd.close
puts passwd.fileno
