# This is available as part of the standard library.
require 'open3'

Open3.popen3('grep', 'data') { |stdin, stdout, stderr|
  stdin.puts "some\ndata"
  stdin.close
  puts stdout.read
}

# Open3 will use Process.spawn when available. Options can be passed to 
# Process.spawn like so:
Open3.popen3('ls', '-uhh', :err => :out) { |stdin, stdout, stderr|
  puts stdout.read
}
