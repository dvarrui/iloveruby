
require_relative 'base_host'
require 'net/ssh'

class RemoteHost < BaseHost

  def run(command=:none)
    title = "[EXEC] RemoteHost : #{@ip}"
    puts ("=" * title.size)
    puts title
    @command = command unless command == :none
    @success = system("ssh root@#{ip} #{@command}")
  end

end
