#!/usr/bin/env ruby

puts "Executing #{$0}..."

packages = <<-EOF
tree nmap git geany
EOF

def execute(command, debug)
  if debug
    puts "[DEBUG] \'#{command}\'"
  else
    ok = system(command)
    puts "[ERROR] \'#{command}\'" unless ok
  end
end

def install(packages,debug)
  execute "zypper refresh", debug

  names = packages.split().sort
  names.each do |package|
    execute("zypper install -y #{package}", debug)
  end
end

if ARGV.first == '-s'
  debug = true
elsif ARGV.first == '-r'
  debug = false
else
  puts "Usage:"
  puts "        #{$0} OPTIONS"
  puts "Options:"
  puts "  -s    => Simulate installation."
  puts "  -r    => Run installation."
  exit 0
end

install packages, debug
