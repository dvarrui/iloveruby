hosts = File.open('/etc/hosts')

python_code = %Q[import os; print os.fdopen(#{hosts.fileno}).read()]

# The hash as the last arguments maps any file descriptors that should 
# stay open through the exec.
exec 'python', '-c', python_code, {hosts.fileno => hosts}

