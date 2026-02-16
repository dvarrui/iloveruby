puts Process.pid
puts Process.getpgrp

fork { 
  puts Process.pid
  puts Process.getpgrp
}