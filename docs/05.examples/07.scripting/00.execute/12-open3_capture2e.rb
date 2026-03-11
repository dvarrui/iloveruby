#!/usr/bin/env ruby
require "open3"

def execute_and_show(cmd)
  begin
    output, s = Open3.capture2e(cmd)
    status = s.exitstatus
  rescue => e
    output = e.to_s
    status = 1
  end
  puts "  Command: #{cmd}"
  puts "  Output : #{output}"
  puts "  Status : #{status}"
  puts
end

cmds = [ "id root", "id vader", "kk", "rmdir kk", "ping -c 1 1.1.1.1", "ping -c 1 192.168.1.69"]
cmds.each { |cmd| execute_and_show cmd }

