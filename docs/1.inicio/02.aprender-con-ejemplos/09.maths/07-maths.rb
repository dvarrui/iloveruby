#!/usr/bin/env ruby
require "debug"

def show_usage
  puts "Usage: #{$0} NUMBER1 NUMBER2"
  exit 1
end

if ARGV.length != 2
  show_usage
end

# 1. Pedir al usuario dos números enteros N y M.
n = ARGV[0].to_i
m = ARGV[1].to_i

# 2. Factorizar los números
def factorize(number)
  factors = []
  aux = number
  (2..number).each do |i|
    while (aux % i).zero?
      factors << i
      aux /= i
    end
  end
  factors
end

n_factors = factorize(n)
m_factors = factorize(m)

puts "==> n=#{n} | factors: #{n_factors}"
puts "==> m=#{m} | factors: #{m_factors}"

# 3. Calcular los factores comunes
mcd = []
ext1 = n_factors.clone
ext2 = m_factors.clone
n_factors.each do |number|
  if ext2.include? number
    mcd << number
    ind1 = ext1.find_index number
    ext1.delete_at(ind1)
    ind2 = ext2.find_index number
    ext2.delete_at(ind2)
  end
end
mcd = [1] if mcd.empty?

puts "--> ext1: #{ext1}"
puts "--> ext2: #{ext2}"
puts "  > mcd: #{mcd} | MCD=#{mcd.reduce(:*)}"

# 4. Calcular el MCM

mcm = mcd + ext1 + ext2
puts "  > mcm: #{mcm} | MCM=#{mcm.reduce(:*)}"

