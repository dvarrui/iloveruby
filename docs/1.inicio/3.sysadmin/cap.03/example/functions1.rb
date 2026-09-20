#!/usr/bin/env ruby

def ensure_you_are_superuser
  if %x[whoami].chop != 'root'
    puts "Sorry, you must be root!"
    exit 1
  end
end

def do_tasks
  puts "Hello! I'm root!"
  puts "I'm working too hard"
end

ensure_you_are_superuser
do_tasks
