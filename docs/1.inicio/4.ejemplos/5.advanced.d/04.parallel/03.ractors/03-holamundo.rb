#!/usr/bin/env ruby
$VERBOSE=nil

ractors = []
[1, 2, 3].each do |id|
  ractors << Ractor.new("Ractor #{id}") { |name| "[#{name}] PID: #{Process.pid}" }
end

ractors.each { puts _1.take }
