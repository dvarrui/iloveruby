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

# Our parent process will be busy doing some intense mathematics.
# But still wants to know when one of its children exits.

# By trapping the :CHLD signal our process will be notified by the kernel
# when one of its children exits.
trap(:CHLD) do
  # Since Process.wait queues up any data that it has for us we can ask for it
  # here, since we know that one of our child processes has exited.

  puts Process.wait
  dead_processes += 1
  # We exit explicitly once all the child processes are accounted for.
  if dead_processes == child_processes
    puts "[main] CHLD signals trapped!"
    exit
  end
end

# Work it.
loop do
  (Math.sqrt(rand(44)) ** 8).floor
  sleep 1
end

puts "[main] normal end."
