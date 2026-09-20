#!/usr/bin/env ruby
# Requirements: 
#   pip install -U matplotlib
#
require "matplotlib/pyplot"
plt = Matplotlib::Pyplot

xs = [*1..100].map {|x| (x - 50) * Math::PI / 100.0 }
ys = xs.map {|x| Math.sin(x) }

plt.plot(xs, ys)
plt.show()
