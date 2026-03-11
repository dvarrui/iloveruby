
require_relative 'base_host'
require 'net/ssh'

class RemoteHost < BaseHost

  def run(command=:none)
    @command = command unless command == :none
    @success = system("ssh root@#{ip} #{@command}")
  end

  def ssh_run
    text = ""
    begin
      session = Net::SSH.start(@ip)

      if session.class==Net::SSH::Connection::Session
        text = session.exec!( @command )
      end
    rescue Errno::EHOSTUNREACH
      puts( "Host #{@ip} unreachable!")
    rescue Net::SSH::AuthenticationFailed
      puts( "SSH::AuthenticationFailed!")
    rescue Net::SSH::HostKeyMismatch
      puts('SSH::HostKeyMismatch!')
      puts("* The destination server's fingerprint is not matching what is in your local known_hosts file.")
      puts('* Remove the existing entry in your local known_hosts file')
      puts("* Try this => ssh-keygen -f '/home/USERNAME/.ssh/known_hosts' -R #{@ip}")
    rescue Exception => e
      puts( "[#{e.class}] SSH on <username@#{ip}> exec: " + @command)
    end

    puts text
  end
end
