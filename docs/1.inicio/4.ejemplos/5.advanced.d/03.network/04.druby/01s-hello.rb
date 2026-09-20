#!/usr/bin/env ruby

require 'drb/drb'

class Puts
  def initialize(stream=$stdout)
    @stream = stream
  end

  def puts(str)
    @stream.puts(str)
  end
end

uri = "druby://localhost:12345"
DRb.start_service(uri, Puts.new)
puts "[INFO] Listen => #{DRb.uri}"
DRb.thread.join()
