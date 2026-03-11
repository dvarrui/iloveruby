#!/usr/bin/env ruby

cmds = ["id root" , "id vader"]

cmds.each do |cmd|
  puts "==> Executing: #{cmd}"
  system(cmd)
  puts "==> Exit code: #{$?.exitstatus}\n\n"
end
