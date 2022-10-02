reader, writer = IO.pipe
writer.write("Into the pipe I go...")
writer.close
puts reader.read

