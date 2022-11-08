#!/usr/bin/env ruby

# We create 3 child processes.
3.times do
  fork do
    # Each one sleeps for a random amount of number less than 5 seconds.
    sleep rand(5)
  end
end

3.times do
  # We wait for each child process to exit and print the pid that
  # gets returned.
  puts Process.wait
end  
