
require_relative 'host/local_host'
require_relative 'host/remote_host'

class ExecManager
  
  def run
    puts "[EXEC] LocalHost:"
    h1 = LocalHost.new
    h1.run('hostname')
    h1.run('pwd')
    h1.run('whoami')
    puts "[EXEC] RemoteHost:"
    h2 = RemoteHost.new('192.168.1.111')
    h2.run('hostname')
    h2.run('pwd')
    h2.run('whoami')
  end

end
