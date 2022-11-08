#!/usr/bin/env ruby

# We create 5 child processes.
5.times do
  fork do
    # Each generates a random number. If even they exit
    # with a 111 exit code, otherwise they use a 112 exit code.
    if rand(5).even?
      exit 111
    else
      exit 112
    end
  end
end

5.times do
  # We wait for each of the child processes to exit.
  pid, status = Process.wait2

  # If the child process exited with the 111 exit code
  # then we know they encountered an even number.
  if status.exitstatus == 111
    puts "#{pid} encountered an even number!"
  else
    puts "#{pid} encountered an odd number!"
  end
end
