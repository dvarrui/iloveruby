#!/usr/bin/env ruby
unless ARGV.first
  puts "Usage: #{$0} FILENAME"
  puts "       FILENAME must contain a list like this: "
  puts "         Name1:hi  => Say hello to Name1"
  puts "         Name2:bye => Say Bye-bye to Name2"
  puts "         #Name3:hi => Ignore Name3"
  exit 1
end

filename = ARGV.first
lines = %x[cat #{filename} | grep -v '#'].split("\n")

for line in lines do
  items = line.split(":")
  if items[1] == 'hi'
    puts "Hello #{items[0]}!"
  elsif items[1] == 'bye'
    puts "Bye-bye #{items[0]}!"
  end
end
