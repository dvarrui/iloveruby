# An IO object is passed into the block. In this case we open the stream
# for writing, so the stream is set to the STDIN of the spawned process. 
#
# If we open the stream for reading (the default) then
# the stream is set to the STDOUT of the spawned process.
IO.popen('less', 'w') { |stream|
  stream.puts "some\ndata"
}
