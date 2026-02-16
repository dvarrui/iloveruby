#!/usr/bin/env ruby

module Pipelines
  refine Kernel do
    def operation(...) = proc(...).curry
  end

  refine Object do
    def >>(callable) = callable.call(self)
  end
end

using Pipelines

Upcase = operation { |text| text.upcase }
Reverse = operation { |text| text.reverse }

puts ("obiwan" >> Upcase >> Reverse)
# => NAWIBO
