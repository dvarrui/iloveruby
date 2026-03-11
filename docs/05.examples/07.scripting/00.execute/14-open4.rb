#!/usr/bin/env ruby 
require "open4"

status = Open4::popen4("sh") do |pid, stdin, stdout, stderr|
  stdin.puts "echo 42.out"
  stdin.puts "echo 42.err 1>&2"
  stdin.close

  puts "pid        : #{ pid }"
  puts "stdout     : #{ stdout.read.strip }"
  puts "stderr     : #{ stderr.read.strip }"
end

puts "status     : #{ status.inspect }"
puts "exitstatus : #{ status.exitstatus }"

# pid        : 17295
# stdout     : 42.out
# stderr     : 42.err
# status     : #<Process::Status: pid=17295,exited(0)>
# exitstatus : 0
