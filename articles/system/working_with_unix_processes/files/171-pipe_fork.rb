#!/usr/bin/env ruby

reader, writer = IO.pipe

fork do
  reader.close

  10.times do
    # heavy lifting
    writer.puts "Another one bites the dust"
  end
end

writer.close
while message = reader.gets
  $stdout.puts message
end
