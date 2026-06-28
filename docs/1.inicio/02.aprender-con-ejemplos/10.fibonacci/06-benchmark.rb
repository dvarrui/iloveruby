#!/usr/bin/env ruby

require 'benchmark'

def iterativo(n)
  return 0 if n == 0
  a, b = 0, 1
  (n - 1).times { a, b = b, a + b }
  b
end

def recursivo(n)
  return n if n <= 1
  recursivo(n - 1) + recursivo(n - 2)
end

def memoizado(n, cache = {})
  return n if n <= 1
  cache[n] ||= memoizado(n - 1, cache) + memoizado(n - 2, cache)
end


def enumerator(n)
  fib_enumerator = Enumerator.new do |yielder|
    a, b = 0, 1
    loop do
      yielder << a
      a, b = b, a + b
    end
  end

  fib_enumerator.take(n).last
end

n = 30 # Usamos 30 porque la recursión pura es muy lenta con números más altos

Benchmark.bm(15) do |x|
  x.report("Iterativo :")   { iterativo(n) }
  x.report("Recursivo :")   { recursivo(n) }
  x.report("Memoizado :")   { memoizado(n) }
  x.report("Enumerator:")   { enumerator(n) }
end