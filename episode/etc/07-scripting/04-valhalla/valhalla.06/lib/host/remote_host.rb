
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
    screen = `ssh root@#{ip} #{@command}`
    @output << { :command => @command, :result => screen.split("\n") }
  end

end
