
require_relative 'host/local_host'
require_relative 'host/remote_host'

class ExecManager

  def initialize(command, hosts)
    @command = command
    @hosts = hosts
  end

  def run
    print "[MANAGER] run #{Rainbow(@command).yellow.bright}"
    puts  " into #{Rainbow(@hosts).yellow.bright}"
    h1 = LocalHost.new
    h1.run(@command)
    h2 = RemoteHost.new('192.168.1.111')
    h2.run(@command)
  end

end
