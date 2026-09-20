#!/usr/bin/env ruby

require "benchmark"

def calc(max)
  total = 0
  (1..max).each { total += _1**2 }
  total
end

Benchmark.bm do |x|
  x.report("calc 0009") { calc(9) }
  x.report("calc 0099") { calc(99) }
  x.report("calc 0999") { calc(999) }
  x.report("calc 9999") { calc(9999) }
end

