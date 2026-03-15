#!/usr/bin/env ruby

cmds = ["id root" , "id vader"]

cmds.each do |cmd|
  puts "==> Execute: #{cmd}"
  begin
    output = `#{cmd}`
    puts "==> Output: \n#{output}"
  rescue => e
    output = e
    puts "==> Error: \n#{output}"
  end
  puts "==> Exit code: #{$?.exitstatus}\n\n"
end
