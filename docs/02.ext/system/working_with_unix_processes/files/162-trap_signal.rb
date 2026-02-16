#!/usr/bin/env ruby

child_processes = 3
dead_processes = 0
# We fork 3 child processes.
child_processes.times do
  fork do
    # They sleep for 3 seconds.
    sleep 3
  end
end

# Sync $stdout so the call to #puts in the CHLD handler isn't
# buffered. Can cause a ThreadError if a signal handler is
# interrupted after calling #puts. Always a good idea to do
# this if your handlers will be doing IO.
$stdout.sync = true

# Our parent process will be busy doing some intense mathematics.
# But still wants to know when one of its children exits.

# By trapping the :CHLD signal our process will be notified by the kernel
# when one of its children exits.
trap(:CHLD) do
  # Since Process.wait queues up any data that it has for us we can ask for it
  # here, since we know that one of our child processes has exited.

  # We loop over a non-blocking Process.wait to ensure that any dead child
  # processes are accounted for.
  begin
    while pid = Process.wait(-1, Process::WNOHANG)
      puts "[trap] signal from #{pid}"
      dead_processes += 1
    end
  rescue Errno::ECHILD
  end
end

loop do
  # We exit ourself once all the child processes are accounted for.
  if dead_processes == child_processes
    puts "[main] All CHLD signals trapped!"
    exit
  end
  sleep 1
end

puts "[main] exit without waiting1"
