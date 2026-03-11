
require_relative 'base_host'
require 'net/ssh'

class RemoteHost < BaseHost

  def info
    title = Rainbow("[EXEC] RemoteHost : #{@ip}").aqua
    puts ("=" * 50)
    puts title
  end

  def run(command=:none)
    @command = command unless command == :none
    @success = system("ssh root@#{ip} #{@command}")
  end

end
