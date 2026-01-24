reader, writer = IO.pipe
reader.write("Trying to get the reader to write something")
