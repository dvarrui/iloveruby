trap(:INT) { puts 'This is the first signal handler' }

old_handler = trap(:INT) {
  old_handler.call
  puts 'This is the second handler'
  exit
}
sleep 5 # so that we have time to send it a signal
