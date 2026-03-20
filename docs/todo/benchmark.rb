# Ruby benchmark: https://x.com/kukicola/status/2021588916524978650
#   Ruby batteries included #7/8: Benchmark  
#   "I think X is faster" is not an argument. Prove it.  
#   Ruby ships a benchmarking tool. Use it before every performance PR.

require "benchmark"

n = 1_000_000

Benchmark.bm(15) do |x|
  x.report("map + join")    { n.times { [1,2,3].map(&:to_s).join(",") } }
  x.report("interpolation") { n.times { "#{1}, #{2}, #{3}" } }
end
