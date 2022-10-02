system_handler = trap(:INT) {
  puts 'about to exit!'
  system_handler.call
}
sleep 5 # so that we have time to send it a signal

