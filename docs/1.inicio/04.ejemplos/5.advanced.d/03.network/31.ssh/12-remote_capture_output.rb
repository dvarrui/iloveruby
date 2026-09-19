#!/usr/bin/env ruby
require "net/ssh"

user = "vagrant"
pass = "vagrant"
host = "192.168.1.16"

def remote_exec_cmd(cmd, ssh)
  # capture only stdout matching a particular pattern
  str_out = ""
  str_err = ""
  ret = ""
  ret = ssh.exec!(cmd) do |channel, stream, data|
    str_out << data if stream == :stdout
    str_err << data if stream == :stderr
  end
  #   puts "  Status  : #{output.exitstatus}\n\n"
  puts "  RET: #{ret.class}" #exitstatus}"
  puts "  CMD: #{cmd}"
  puts "  OUT: #{str_out}"
  puts "  ERR: #{str_err}"
  puts
end

def remote_exec_cmds(cmds, host, user, pass)
  puts "==> Open SSH with #{host}"
  Net::SSH.start( host.to_s, user.to_s, :password => pass.to_s ) do |ssh|
    cmds.each { |cmd| remote_exec_cmd(cmd, ssh) }
  end
  puts "==> Close session"
end

cmds = [ "id vagrant", "id vader", "rmdir kk", "kk", "ping -c 1 1.1.1", "ping -c 1 192.168.1.69" ]
remote_exec_cmds(cmds, host, user, pass)
