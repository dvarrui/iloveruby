#!/usr/bin/env ruby

require "benchmark"

list = (1..9999999).to_a

def calc(value)
  value**2
end

Benchmark.bm do |x|
  x.report(:for_) { for i in list; v = calc(i); end }
  x.report(:each) { list.each do |i| v = calc(i); end }
end


