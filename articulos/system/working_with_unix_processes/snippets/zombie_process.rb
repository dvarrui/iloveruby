message = 'Good Morning'
recipient = 'tree@mybackyard.com'

pid = fork do
  # In this contrived example the parent process forks a child to take
  # care of sending data to the stats collector. Meanwhile the parent
  # process has continued on with its work of sending the actual payload.

  # The parent process doesn't want to be slowed down with this task, and
  # it doesn't matter if this would fail for some reason.
  StatsCollector.record message, recipient
end

# This line ensures that the process performing the stats collection
# won't become a zombie.
Process.detach(pid)

